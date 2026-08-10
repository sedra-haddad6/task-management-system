import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_management_app/core/services/rest_api/rest_api.dart';

import '../state_management/obs.dart';
import '../state_management/variable_status.dart';

class PaginationController<T> extends GetxController {
  final Future<ResponseModel> Function(int, CancelToken cancel) fetchApi;
  final T Function(Map<String, dynamic> json) fromJson;
  double closeToListEnd;

  late ScrollController scrollController;

  PaginationController({
    required this.fromJson,
    required this.fetchApi,
    ScrollController? scrollController,
    this.closeToListEnd = 500,
  }) {
    if (scrollController == null) {
      this.scrollController = ScrollController();
    } else {
      this.scrollController = scrollController;
    }
  }

  void updateValues({
    ScrollController? scrollController,
    double? closeToListEnd,
  }) {
    if (scrollController != null) {
      this.scrollController = scrollController;
    }
    if (closeToListEnd != null) {
      this.closeToListEnd = closeToListEnd;
    }
    log("PaginationController update the values", name: "Pager");
  }

  int currentPage = 1;

  final RxBool _isFinished = false.obs;
  bool get isFinished => _isFinished.value;
  set isFinished(bool value) => _isFinished.value = value;

  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  Obs<List<T>> data = Obs<List<T>>(null);

  CancelToken? cancel;

  Future<ResponseModel> loadData() async {
    loading = true;
    if (currentPage != 1 && data.status != VariableStatus.hasData) {
      data.status = VariableStatus.hasData;
    } else if (currentPage == 1) {
      data.status = VariableStatus.loading;
    }
    cancel = CancelToken();

    ResponseModel response = await fetchApi(currentPage, cancel!);
    if (response.success) {
      if (response.data.isEmpty) {
        isFinished = true;
        loading = false;
        if (currentPage == 1) {
          data.data = [];
          return response;
        }
      } else {
        data.data = [
          ...data.data ?? [],
          ...(response.data as List).map((element) => fromJson(element)),
        ];
        currentPage++;

        while (!scrollController.hasClients) {
          await 100.milliseconds.delay();
        }
        if (scrollController.position.maxScrollExtent > 1) {
          scrollController.jumpTo(scrollController.offset + 0.1);
        }
        log(
          'scrollController.offset: ${scrollController.offset}',
          name: "Pager",
        );
        log(
          'scrollController.position.maxScrollExtent: ${scrollController.position.maxScrollExtent}',
          name: "Pager",
        );
        if (scrollController.offset >
                scrollController.position.maxScrollExtent - closeToListEnd &&
            !isFinished) {
          await loadData();
        }
      }
    } else if (response.errorType is CANCELED) {
      return response;
    } else {
      data.error = response.message;
    }
    loading = false;
    return response;
  }

  Future<void> refreshData() async {
    currentPage = 1;
    isFinished = false;
    loading = false;
    data.reset();
    if (cancel != null) {
      cancel!.cancel();
    }
    await loadData();
  }

  Future<void> onInitAsync() async {
    await loadData();
    if (scrollController.hasClients) {
      scrollController.addListener(() {
        if (!isFinished &&
            !loading &&
            scrollController.offset >
                scrollController.position.maxScrollExtent - closeToListEnd) {
          loadData();
        }
      });
    }
  }

  @override
  void onInit() {
    onInitAsync();
    super.onInit();
  }

  @override
  void onClose() {
    if (cancel != null) cancel!.cancel();
    scrollController.dispose();
    super.onClose();
  }
}
