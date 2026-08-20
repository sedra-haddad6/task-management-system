import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:task_management_app/core/routes/routes.dart';
import 'package:task_management_app/core/services/state_management/obs_builder.dart';

import '../../../core/style/app_colors.dart';
import '../../tasks/models/task_card.dart';
import '../../tasks/task_details/models/nav.dart';

import 'controller.dart';
import 'models/nav.dart';

class TeamDetailsPage extends StatelessWidget {
  const TeamDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamDetailsPageNav nav =
        Get.arguments as TeamDetailsPageNav;

    final TeamDetailsPageController controller = Get.put(
      TeamDetailsPageController(nav: nav),
      tag: nav.id.toString(),
    );

    return ObsBuilder(
      obs: controller.teamDetails,

      loadingBuilder: (context) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },

      errorBuilder: (context, error) {
        return Scaffold(
          appBar: AppBar(),

          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  error,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: controller.fetchDetails,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      },

      builder: (context, teamDetails) {
        return Scaffold(
          appBar: AppBar(
            title: Text(teamDetails.name),
          ),

          body: RefreshIndicator(
            onRefresh: controller.refreshDetails,

            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),

              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        teamDetails.managerName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: context.colors.darkBlue,
                        ),
                      ),

                      const SizedBox(height: 4),

                      if (teamDetails.managerEmail != null)
                        Text(
                          teamDetails.managerEmail!,
                          style: TextStyle(
                            color: context.colors.fieldBorder,
                          ),
                        ),

                      const Divider(
                        height: 32,
                        indent: 60,
                        endIndent: 60,
                      ),

                      Text(
                        "team_details.score".tr(
                          args: [
                            teamDetails.score.toString(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "team_details.remaining_tasks_message".tr(
                          args: [
                            teamDetails.pendingTasksCount.toString(),
                          ],
                        ),
                        style: TextStyle(
                          color: context.colors.black.withOpacity(.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                if (teamDetails.tasks.isNotEmpty)
                  ...teamDetails.tasks.map(
                    (task) => TaskCard(
                      task: task,
                      onTap: () => Get.toNamed(
                        Pages.taskDetails.value,
                        arguments: TaskDetailsPageNav(
                          task.id,
                        ),
                      ),
                    ),
                  ),

                if (teamDetails.tasks.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: Text(
                        "No tasks available",
                        style: TextStyle(
                          color: context.colors.fieldBorder,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}