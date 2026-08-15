import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:task_management_app/core/routes/routes.dart';
import 'package:task_management_app/core/services/rest_api/rest_api.dart';
import 'package:task_management_app/core/services/state_management/obs.dart';

import '../models/task_step.dart';
import '../task_success/models/nav.dart' as success_nav;
import 'models/nav.dart';
import 'models/task_details.dart';

class TaskDetailsPageController extends GetxController {
  final TaskDetailsPageNav nav;

  TaskDetailsPageController({required this.nav});

  Obs<TaskDetails> taskDetails = Obs(null);

  @override
  void onInit() {
    fetchDetails();
    super.onInit();
  }

  Future<void> fetchDetails() async {
    // 
    //  TODO when the api is ready 
    
    // ResponseModel response = await APIService.instance.request(
    //   Request(
    //     endPoint: EndPoints.task(nav.id), 
    //     fromJson: TaskDetails.fromJson,
    //   ),
    // );
    // if (response.success) {
    //   taskDetails.data = response.data;
    // } else {
    //   taskDetails.error = response.message;
    // }

    
    //  بيانات وهمية مؤقتة
    // ============================================================
    await Future.delayed(const Duration(milliseconds: 400));

    taskDetails.data = TaskDetails(
      id: nav.id,
      name: "create and save folders",
      deadline: "22/5",
      teamName: "IT team",
      assignedByName: "Ahmad Hameed",
      assignedToName: "Khaled Khaled",
      steps: [
        TaskStep(id: "1", description: "Project Receipt"),
        TaskStep(id: "2", description: "File Review"),
        TaskStep(id: "3", description: "Project Classification (Type)"),
        TaskStep(id: "4", description: "File Renaming"),
        TaskStep(id: "5", description: "Upload to Server/Storage"),
      ],
    );
  }

  void toggleStep(String stepId) {
    final step = taskDetails.data!.steps.firstWhere((s) => s.id == stepId);
    step.isChecked = !step.isChecked;
    taskDetails.data = taskDetails.data; // مشان الواجهة تعيد الرسم
  }

  Future<void> completeTask() async {
    if (!taskDetails.data!.allStepsChecked) {
      Get.snackbar("", "task_details.complete_all_steps_first".tr());
      return;
    }

    
// TODO when the api is ready 
//    
    // ResponseModel response = await APIService.instance.request(
    //   Request(
    //     method: RequestMethod.post,
    //     endPoint: EndPoints.completeTask(nav.id), // ضيفيها بـ end_points.dart
    //   ),
    // );
    // if (response.success) {
    //   Get.toNamed(
    //     Pages.taskSuccess.value,
    //     arguments: success_nav.TaskSuccessPageNav(score: response.data["score"]),
    //   );
    // } else {
    //   Get.snackbar("", response.message);
    // }

    //  dummy
    await Future.delayed(const Duration(milliseconds: 500));
    Get.toNamed(
      Pages.taskSuccess.value,
      arguments: success_nav.TaskSuccessPageNav(score: 150),
    );
  }
}