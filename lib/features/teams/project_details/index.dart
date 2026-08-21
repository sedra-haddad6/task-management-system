import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:task_management_app/core/routes/routes.dart';
import 'package:task_management_app/core/services/state_management/obs_builder.dart';
import 'package:task_management_app/features/tasks/models/task_card.dart';

import '../../../core/style/app_colors.dart';

import '../../tasks/task_details/models/nav.dart'
    as task_nav;

import 'controller.dart';
import 'models/nav.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailsPageNav nav =
        Get.arguments as ProjectDetailsPageNav;

    final ProjectDetailsPageController controller =
        Get.put(
      ProjectDetailsPageController(
        nav: nav,
      ),
      tag: '${nav.teamId}_${nav.projectId}',
    );

    return ObsBuilder(
      obs: controller.projectDetails,

      //=========================================
      // Loading
      //=========================================

      loadingBuilder: (context) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: context.colors.darkBlue,
            ),
          ),
        );
      },

      //=========================================
      // Error
      //=========================================

      errorBuilder: (
        context,
        error,
      ) {
        return Scaffold(
          appBar: AppBar(),

          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    error,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed:
                        controller.fetchDetails,
                    child: Text(
                      "common.retry".tr(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

      //=========================================
      // Content
      //=========================================

      builder: (
        context,
        projectDetails,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              projectDetails.title,
            ),
          ),

          body: RefreshIndicator(
            onRefresh:
                controller.refreshDetails,

            child: ListView(
              physics:
                  const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),

              children: [
                //=========================================
                // Project Status
                //=========================================

                Center(
                  child: Text(
                    projectDetails.status,
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colors.black
                          .withOpacity(.5),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                //=========================================
                // Tasks
                //=========================================

                Obx(() {
                  // Loading
                  if (controller
                      .isTasksLoading.value) {
                    return Padding(
                      padding:
                          const EdgeInsets.all(30),

                      child: Center(
                        child:
                            CircularProgressIndicator(
                          color: context
                              .colors
                              .darkBlue,
                        ),
                      ),
                    );
                  }

                  // Error
                  if (controller
                          .hasTasksError.value &&
                      controller.tasks.isEmpty) {
                    return Padding(
                      padding:
                          const EdgeInsets.all(30),

                      child: Column(
                        children: [
                          Text(
                            controller
                                .tasksErrorMessage
                                .value,
                            textAlign:
                                TextAlign.center,
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          ElevatedButton(
                            onPressed:
                                controller
                                    .fetchProjectTasks,
                            child: Text(
                              "common.retry"
                                  .tr(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // No Tasks
                  if (controller.tasks.isEmpty) {
                    return Padding(
                      padding:
                          const EdgeInsets.all(24),

                      child: Center(
                        child: Text(
                          "project_details.no_tasks"
                              .tr(),
                        ),
                      ),
                    );
                  }

                  //=========================================
                  // Tasks
                  //=========================================

                  return Column(
                    children: controller.tasks
                        .map(
                          (task) => TaskCard(
                            task: task,

                            onTap: () {
                              Get.toNamed(
                                Pages.taskDetails.value,

                                arguments:
                                    task_nav
                                        .TaskDetailsPageNav(
                                  task.id,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}