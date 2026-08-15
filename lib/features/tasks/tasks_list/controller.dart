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

  void updateSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _searchQuery = value;
      paginationController?.refreshData();
    });
  }

  void updateFilter(TaskStatus? status) {
    _statusFilter = (_statusFilter == status) ? null : status;
    paginationController?.refreshData();
    update();
  }

  TaskStatus? get currentFilter => _statusFilter;

  Future<ResponseModel> fetchTasks(int page, CancelToken cancel) async {


    //// TODO when the api is ready 
    

    // return await APIService.instance.request(
    //   Request(
    //     endPoint: EndPoints.tasks, // ضيفيها بـ end_points.dart
    //     params: {
    //       "page": page,
    //       if (_searchQuery.isNotEmpty) "search": _searchQuery,
    //       if (_statusFilter != null) "status": _statusFilter!.name,
    //     },
    //     cancelToken: cancel,
    //   ),
    // );

    //  dummy
    await Future.delayed(const Duration(milliseconds: 400));

    if (page > 1) {
      return ResponseModel(success: true, message: "", data: []);
    }

    final allTasks = [
      {"id": 1, "name": "create and save folders", "deadline": "22/5", "team_name": "IT team", "status": "pending"},
      {"id": 2, "name": "create and save folders", "deadline": "22/5", "team_name": "HR team", "status": "in_progress"},
      {"id": 3, "name": "create and save folders", "deadline": "22/5", "team_name": "Work team", "status": "done"},
      {"id": 4, "name": "work on flutter project", "deadline": "22/5", "team_name": "IT team", "status": "in_progress"},
      {"id": 5, "name": "create and save folders", "deadline": "22/5", "team_name": "Study team", "status": "pending"},
    ];

    final filtered = allTasks.where((task) {
      final matchesSearch = _searchQuery.isEmpty ||
          (task["name"] as String).toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _statusFilter == null || task["status"] == _statusFilter!.name;
      return matchesSearch && matchesFilter;
    }).toList();

    return ResponseModel(success: true, message: "", data: filtered);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}