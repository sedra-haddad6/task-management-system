import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

import 'package:task_management_app/core/services/rest_api/rest_api.dart';
import 'package:task_management_app/core/services/state_management/obs.dart';
import 'package:task_management_app/features/tasks/models/task.dart';

import 'models/nav.dart';
import 'models/project_details.dart';

class ProjectDetailsPageController extends GetxController {
  final ProjectDetailsPageNav nav;

  ProjectDetailsPageController({
    required this.nav,
  });

  //=========================================
  // Project Details
  //=========================================

  final Obs<ProjectDetails> projectDetails = Obs(null);

  //=========================================
  // Tasks
  //=========================================

  final RxList<Task> tasks = <Task>[].obs;

  final RxBool isTasksLoading = false.obs;

  final RxBool hasTasksError = false.obs;

  final RxString tasksErrorMessage = ''.obs;

  //=========================================
  // Init
  //=========================================

  @override
  void onInit() {
    super.onInit();

    fetchDetails();
  }

  //=========================================
  // Fetch Project Details + Tasks
  //=========================================

  Future<void> fetchDetails() async {
    // Reset task state
    isTasksLoading.value = true;
    hasTasksError.value = false;
    tasksErrorMessage.value = '';

    //=========================================
    // Fetch Project
    //=========================================

    final ResponseModel projectResponse =
        await APIService.instance.request(
      Request(
        endPoint: EndPoints.project(
          nav.teamId,
          nav.projectId,
        ),
        method: RequestMethod.get,
      ),
    );

    if (!projectResponse.success) {
      isTasksLoading.value = false;

      projectDetails.error =
          projectResponse.message;

      return;
    }

    //=========================================
    // Extract Project JSON
    //=========================================

    final dynamic projectData =
        projectResponse.data;

    Map<String, dynamic>? projectJson;

    if (projectData is Map<String, dynamic>) {
      final dynamic nestedProject =
          projectData['project'];

      if (nestedProject is Map) {
        projectJson =
            Map<String, dynamic>.from(
          nestedProject,
        );
      } else {
        projectJson =
            Map<String, dynamic>.from(
          projectData,
        );
      }
    }

    if (projectJson == null) {
      isTasksLoading.value = false;

      projectDetails.error =
          "project_details.load_error".tr();

      return;
    }

    //=========================================
    // Fetch Project Tasks
    //=========================================

    await fetchProjectTasks();

    //=========================================
    // Build Project Details
    //=========================================

    projectDetails.data = ProjectDetails(
      id: _parseInt(
        projectJson['id'],
      ),
      title:
          projectJson['title']?.toString() ??
              '',
      status:
          projectJson['status']?.toString() ??
              'pending',
      tasks: tasks.toList(),
    );
  }

  //=========================================
  // Fetch Project Tasks
  //=========================================

  Future<void> fetchProjectTasks() async {
    isTasksLoading.value = true;
    hasTasksError.value = false;
    tasksErrorMessage.value = '';

    final ResponseModel response =
        await APIService.instance.request(
      Request(
        endPoint: EndPoints.projectTasks(
          nav.teamId,
          nav.projectId,
        ),
        method: RequestMethod.get,
      ),
    );

    if (!response.success) {
      tasks.clear();

      hasTasksError.value = true;

      tasksErrorMessage.value =
          response.message;

      isTasksLoading.value = false;

      return;
    }

    try {
      final dynamic data = response.data;

      List<dynamic> tasksJson = [];

      // Backend:
      //
      // data: {
      //    tasks: [...]
      // }

      if (data is Map<String, dynamic>) {
        final dynamic list = data['tasks'];

        if (list is List) {
          tasksJson = list;
        }
      }

      // In case API returns the list directly
      else if (data is List) {
        tasksJson = data;
      }

      //=========================================
      // Convert JSON -> Task
      //=========================================

      final List<Task> loadedTasks =
          tasksJson
              .whereType<Map>()
              .map(
                (json) => Task.fromJson(
                  Map<String, dynamic>.from(json),
                ),
              )
              .toList();

      tasks.assignAll(loadedTasks);
    } catch (e) {
      tasks.clear();

      hasTasksError.value = true;

      tasksErrorMessage.value =
          e.toString();
    }

    isTasksLoading.value = false;
  }

  //=========================================
  // Retry Tasks
  //=========================================

  Future<void> retryTasks() async {
    await fetchProjectTasks();

    // Update project object with new tasks
    final currentProject =
        projectDetails.data;

    if (currentProject != null) {
      projectDetails.data =
          ProjectDetails(
        id: currentProject.id,
        title: currentProject.title,
        status: currentProject.status,
        tasks: tasks.toList(),
      );
    }
  }

  //=========================================
  // Refresh
  //=========================================

  Future<void> refreshDetails() async {
    projectDetails.reset();

    await fetchDetails();
  }

  //=========================================
  // Parse Int
  //=========================================

  int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }
}