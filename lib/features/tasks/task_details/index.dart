import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:task_management_app/core/services/state_management/obs_builder.dart';
import 'package:task_management_app/core/widgets/buttons/elevated_button.dart';

import '../../../core/style/app_colors.dart';
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

      loadingBuilder: (context) =>  Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: context.colors.darkBlue,
          ),
        ),
      ),

      errorBuilder: (context, error) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(error),
        ),
      ),

      builder: (context, taskDetails) {
        return Scaffold(
          backgroundColor: context.colors.white,

          appBar: AppBar(
            backgroundColor: context.colors.white,
            elevation: 0,
            centerTitle: true,

            leading: IconButton(
              onPressed: () => Get.back(),
              icon:  Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: context.colors.darkBlue,
              ),
            ),

            title: Text(
              "task_details.title".tr(),
              style:  TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.colors.darkBlue,
              ),
            ),
          ),

          body: ListView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),

            children: [

              const SizedBox(height: 8),

              // =========================================================
              // TASK CARD
              // =========================================================

              TaskCard(
                task: Task(
                  id: taskDetails.id,
                  name: taskDetails.name,
                  deadline: taskDetails.deadline,
                  teamName: taskDetails.teamName,
                  status: TaskStatus.pending,
                ),
                onTap: () {},
              ),

              const SizedBox(height: 14),

              // =========================================================
              // POMODORO BUTTON
              // =========================================================

              Align(
                alignment: Alignment.centerRight,

                child: Material(
                  color: Colors.transparent,

                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),

                    onTap: () {
                      Get.to(
                        () => TimerPage(
                          task: taskDetails,
                        ),
                      );
                    },

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: context.colors.lightBlue,
                        borderRadius: BorderRadius.circular(22),
                      ),

                      child:  Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 18,
                            color: context.colors.darkBlue,
                          ),

                          SizedBox(width: 7),

                          Text(
                            "Pomodoro",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: context.colors.darkBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================================================
              // TASK INFORMATION CARD
              // =========================================================

              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: context.colors.white,

                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(
                    color: context.colors.fieldBorder.withOpacity(.35),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: context.colors.darkBlue.withOpacity(.06),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // Section title
                    Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,

                          decoration:  BoxDecoration(
                            color: context.colors.lightBlue,
                            shape: BoxShape.circle,
                          ),

                          child:  Icon(
                            Icons.info_outline_rounded,
                            size: 20,
                            color: context.colors.darkBlue,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "Task Information",
                          style:  TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: context.colors.darkBlue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _InfoRow(
                      icon: Icons.groups_outlined,
                      title: "task_details.team".tr(),
                      value: taskDetails.teamName,
                    ),

                    const SizedBox(height: 15),

                    _InfoRow(
                      icon: Icons.person_outline_rounded,
                      title: "task_details.assigned_by".tr(),
                      value: taskDetails.assignedByName,
                    ),

                    const SizedBox(height: 15),

                    _InfoRow(
                      icon: Icons.person_pin_outlined,
                      title: "task_details.assigned_to".tr(),
                      value: taskDetails.assignedToName,
                    ),

                    const SizedBox(height: 15),

                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      title: "task_details.deadline".tr(),
                      value: taskDetails.deadline.toString(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // =========================================================
              // STEPS TITLE
              // =========================================================

              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,

                    decoration:  BoxDecoration(
                      color: context.colors.lightBlue,
                      shape: BoxShape.circle,
                    ),

                    child:  Icon(
                      Icons.checklist_rounded,
                      size: 20,
                      color: context.colors.darkBlue,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    "task_details.steps_of_task".tr(),
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: context.colors.darkBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // =========================================================
              // STEPS
              // =========================================================

              Container(
                decoration: BoxDecoration(
                  color: context.colors.white,

                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(
                    color: context.colors.fieldBorder.withOpacity(.35),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: context.colors.darkBlue.withOpacity(.05),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    ...taskDetails.steps.map(
                      (step) => CheckboxListTile(
                        value: step.isChecked,

                        onChanged: (_) =>
                            controller.toggleStep(step.id),

                        title: Text(
                          step.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: step.isChecked
                                ? context.colors.fieldBorder
                                : context.colors.darkBlue,
                            decoration: step.isChecked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),

                        activeColor: context.colors.middleBlue,

                        controlAffinity:
                            ListTileControlAffinity.trailing,

                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                      ),
                    ),

                    // =====================================================
                    // PROGRESS
                    // =====================================================

                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        18,
                        8,
                        18,
                        18,
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                            children: [
                               Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.darkBlue,
                                ),
                              ),

                              Text(
                                "${taskDetails.checkedStepsCount}/${taskDetails.steps.length}",
                                style:  TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.middleBlue,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          LinearProgressIndicator(
                            value: taskDetails.steps.isEmpty
                                ? 0
                                : taskDetails.checkedStepsCount /
                                    taskDetails.steps.length,

                            minHeight: 7,

                            color: context.colors.middleBlue,

                            backgroundColor:
                                context.colors.lightBlue,

                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================================================
              // COMPLETE BUTTON
              // =========================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),

                child: AppElevatedButton(
                  onPressed: controller.completeTask,

                  child: Text(
                    "task_details.complete_send".tr(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


// =======================================================================
// INFORMATION ROW
// =======================================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [

        Container(
          width: 38,
          height: 38,

          decoration: BoxDecoration(
            color: context.colors.lightBlue,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(
            icon,
            size: 19,
            color: context.colors.darkBlue,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,
                style:  TextStyle(
                  fontSize: 11,
                  color: context.colors.fieldBorder,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.colors.darkBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}