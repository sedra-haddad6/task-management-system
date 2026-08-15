import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:task_management_app/core/services/state_management/obs_builder.dart';
import 'package:task_management_app/core/widgets/buttons/elevated_button.dart';
import 'package:task_management_app/core/style/repo.dart';

import '../../timer/index.dart';
import '../models/task.dart';
import '../models/task_card.dart';
import 'controller.dart';
import 'models/nav.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskDetailsPageNav nav = Get.arguments as TaskDetailsPageNav;
    final TaskDetailsPageController controller = Get.put(
      TaskDetailsPageController(nav: nav),
      tag: nav.id.toString(),
    );

    return ObsBuilder(
      obs: controller.taskDetails,
      loadingBuilder: (context) =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      errorBuilder: (context, error) =>
          Scaffold(appBar: AppBar(), body: Center(child: Text(error))),
      builder: (context, taskDetails) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "task_details.title".tr(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: StyleRepo.darkBlue,
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              // نفس بطاقة المهمة، بس onTap فاضية لأننا أصلاً واقفين جواها
              TaskCard(
                task: Task(
                  id: taskDetails.id,
                  name: taskDetails.name,
                  deadline: taskDetails.deadline,
                  teamName: taskDetails.teamName,
                  status: TaskStatus.pending, // مش مستخدمة بصريا هون
                ),
                onTap: () {},
              ),

              Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Align(
    alignment: Alignment.centerRight,
    child: InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        Get.to(
          () => TimerPage(
            task: taskDetails,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: StyleRepo.lightBlue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_outlined,
              size: 19,
              color: StyleRepo.darkBlue,
            ),
            SizedBox(width: 6),
            Text(
              "Pomodoro",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: StyleRepo.darkBlue,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${"task_details.team".tr()} : ${taskDetails.teamName}"),
                    const SizedBox(height: 4),
                    Text("${"task_details.assigned_by".tr()} : ${taskDetails.assignedByName}"),
                    const SizedBox(height: 4),
                    Text("${"task_details.assigned_to".tr()} : ${taskDetails.assignedToName}"),
                    const SizedBox(height: 4),
                    Text("${"task_details.deadline".tr()} : ${taskDetails.deadline}"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "task_details.steps_of_task".tr(),
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              ...taskDetails.steps.map(
                (step) => CheckboxListTile(
                  value: step.isChecked,
                  onChanged: (_) => controller.toggleStep(step.id),
                  title: Text(step.description),
                  activeColor: StyleRepo.middleBlue,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LinearProgressIndicator(
                  value: taskDetails.steps.isEmpty
                      ? 0
                      : taskDetails.checkedStepsCount / taskDetails.steps.length,
                  minHeight: 6,
                  color: StyleRepo.middleBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: AppElevatedButton(
                  onPressed: controller.completeTask,
                  child: Text("task_details.complete_send".tr()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}