import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:task_management_app/core/services/pagination/controller.dart';
import 'package:task_management_app/core/services/rest_api/rest_api.dart';

import '../models/task.dart';

class TasksListPageController extends GetxController {
  PaginationController<Task>? paginationController;

  String _searchQuery = "";

  TaskStatus? _statusFilter;

  Timer? _debounce;

  //=========================================
  // Search
  //=========================================

  void updateSearch(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 400),
      () {
        _searchQuery = value;

        paginationController?.refreshData();
      },
    );
  }

  //=========================================
  // Filter
  //=========================================

  void updateFilter(TaskStatus? status) {
    _statusFilter =
        (_statusFilter == status)
            ? null
            : status;

    paginationController?.refreshData();

    update();
  }

  //=========================================
  // Current Filter
  //=========================================

  TaskStatus? get currentFilter =>
      _statusFilter;

  //=========================================
  // Fetch My Tasks
  //=========================================

  Future<ResponseModel> fetchTasks(
    int page,
    CancelToken cancel,
  ) async {
    return await APIService.instance.request(
      Request(
        endPoint: EndPoints.myTasks,

        params: {
          "page": page,

          if (_searchQuery.isNotEmpty)
            "search": _searchQuery,

          if (_statusFilter != null)
            "status": _statusFilter!.name,
        },

        cancelToken: cancel,
      ),
    );
  }

  //=========================================
  // Dispose
  //=========================================

  @override
  void onClose() {
    _debounce?.cancel();

    super.onClose();
  }
}