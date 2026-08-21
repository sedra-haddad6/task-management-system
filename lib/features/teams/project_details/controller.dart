import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

import 'package:task_management_app/core/services/rest_api/rest_api.dart';
import 'package:task_management_app/core/services/state_management/obs.dart';
import 'package:task_management_app/features/tasks/models/task.dart';

import 'models/nav.dart';
import 'models/project_details.dart';

class ProjectDetailsPageController extends GetxController {
  final ProjectDetailsPageNav nav;

  ProjectDetailsPageController({required this.nav});

  Obs<ProjectDetails> projectDetails = Obs(null);

  @override
  void onInit() {
    fetchDetails();
    super.onInit();
  }

  Future<void> fetchDetails() async {
    // نداء أول: معلومات المشروع (endpoint من النوع اللي فيه success/data)
    ResponseModel projectResponse = await APIService.instance.request(
      Request(endPoint: EndPoints.project(nav.teamId, nav.projectId)),
    );

    if (!projectResponse.success) {
      projectDetails.error = projectResponse.message;
      return;
    }

    final projectJson = projectResponse.data?["project"];

    if (projectJson == null) {
      projectDetails.error = "project_details.load_error".tr();
      return;
    }
//TODO
    // نداء تاني: مهام هاد المشروع
    // endpoint من النوع اللي بدون success/data، لهيك بنقرأ الرد يدوياً
    ResponseModel tasksResponse = await APIService.instance.request(
      Request(endPoint: EndPoints.projectTasks(nav.teamId, nav.projectId)),
    );

    List<Task> tasks = [];

    if (tasksResponse.success && tasksResponse.data?["tasks"] is List) {
      tasks = (tasksResponse.data["tasks"] as List)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList();
    }

    projectDetails.data = ProjectDetails(
      id: projectJson["id"],
      title: projectJson["title"],
      status: projectJson["status"] ?? "pending",
      tasks: tasks,
    );
  }

  Future<void> refreshDetails() async {
    projectDetails.reset();
    await fetchDetails();
  }
}