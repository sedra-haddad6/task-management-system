import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

import 'package:task_management_app/core/routes/routes.dart';
import 'package:task_management_app/core/services/rest_api/rest_api.dart';
import 'package:task_management_app/core/services/state_management/obs.dart';

import '../models/task_step.dart';
import '../task_success/models/nav.dart'
    as success_nav;

import 'models/nav.dart';
import 'models/task_details.dart';

class TaskDetailsPageController
    extends GetxController {
  final TaskDetailsPageNav nav;

  TaskDetailsPageController({
    required this.nav,
  });

  final Obs<TaskDetails> taskDetails =
      Obs(null);

  @override
  void onInit() {
    super.onInit();

    fetchDetails();
  }

  //=========================================
  // Fetch Task Details
  //=========================================

  Future<void> fetchDetails() async {
    final ResponseModel response =
        await APIService.instance.request(
      Request(
        endPoint: EndPoints.task(nav.id),
        method: RequestMethod.get,
      ),
    );

    if (!response.success) {
      taskDetails.error =
          response.message;
      return;
    }

    final dynamic data = response.data;

    Map<String, dynamic>? taskJson;

    if (data is Map<String, dynamic>) {
      final dynamic task =
          data['task'];

      if (task is Map) {
        taskJson =
            Map<String, dynamic>.from(
          task,
        );
      } else {
        taskJson =
            Map<String, dynamic>.from(
          data,
        );
      }
    }

    if (taskJson == null) {
      taskDetails.error =
          "task_details.load_error".tr();
      return;
    }

    taskDetails.data =
        TaskDetails.fromJson(
      taskJson,
    );
  }

  //=========================================
  // Refresh
  //=========================================

  Future<void> refreshDetails() async {
    taskDetails.reset();

    await fetchDetails();
  }

  //=========================================
  // Complete / Uncomplete Step
  //=========================================

  Future<void> toggleStep(
    TaskStep step,
  ) async {
    final bool oldValue =
        step.isChecked;

    final ResponseModel response =
        await APIService.instance.request(
      Request(
        method: oldValue
            ? RequestMethod.delete
            : RequestMethod.post,
        endPoint: oldValue
            ? EndPoints.uncompleteStep(
                step.id,
              )
            : EndPoints.completeStep(
                step.id,
              ),
      ),
    );

    if (!response.success) {
      Get.snackbar(
        "",
        response.message,
      );

      return;
    }

    // Update local UI only after API succeeds.
    step.isChecked = !oldValue;

    taskDetails.data =
        taskDetails.data;
  }

  //=========================================
  // Complete Task
  //=========================================

  Future<void> completeTask() async {
    final details =
        taskDetails.data;

    if (details == null) {
      return;
    }

    if (!details.allStepsChecked) {
      Get.snackbar(
        "",
        "task_details.complete_all_steps_first"
            .tr(),
      );

      return;
    }

    // The backend updates task status
    // automatically when the final step
    // is completed.
    //
    // Therefore we do NOT call a fake
    // /tasks/{id}/complete endpoint here.

    Get.toNamed(
      Pages.taskSuccess.value,
      arguments:
          success_nav.TaskSuccessPageNav(
        score: 0,
      ),
    );
  }
}