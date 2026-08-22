import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:task_management_app/core/routes/routes.dart';
import 'package:task_management_app/core/services/state_management/obs_builder.dart';

import '../../../core/style/app_colors.dart';
import '../project_details/models/nav.dart';

import 'controller.dart';
import 'models/nav.dart';
import 'models/widgets/project_card.dart';

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
        return Scaffold(
          backgroundColor: context.colors.white,
          body: Center(
            child: CircularProgressIndicator(
              color: context.colors.darkBlue,
            ),
          ),
        );
      },

      errorBuilder: (context, error) {
        return Scaffold(
          backgroundColor: context.colors.white,
          appBar: AppBar(),

          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 42,
                    color: context.colors.fieldBorder,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.colors.darkBlue,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: controller.fetchDetails,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        );
      },

      builder: (context, teamDetails) {
        return Scaffold(
          backgroundColor: context.colors.white,

          appBar: AppBar(
            backgroundColor: context.colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              teamDetails.name,
              style: TextStyle(
                color: context.colors.darkBlue,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.exit_to_app_rounded,
                  color: context.colors.darkBlue,
                ),
                tooltip: 'team_details.leave_team'.tr(),
                onPressed: () => _confirmLeaveTeam(context, controller),
              ),
            ],
          ),

          body: RefreshIndicator(
            color: context.colors.darkBlue,
            onRefresh: controller.refreshDetails,

            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),

              children: [
                // ==========================================
                // Manager / Team info card
                // ==========================================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.lightBlue.withOpacity(.35),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: context.colors.lightBlue,
                        child: Icon(
                          Icons.person_rounded,
                          size: 32,
                          color: context.colors.darkBlue,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Text(
                        teamDetails.managerName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: context.colors.darkBlue,
                        ),
                      ),

                      if (teamDetails.managerEmail != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          teamDetails.managerEmail!,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colors.fieldBorder,
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      // Stats row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _StatItem(
                            icon: Icons.emoji_events_outlined,
                            label: 'team_details.score'.tr(),
                            value: teamDetails.score.toString(),
                          ),

                          Container(
                            width: 1,
                            height: 36,
                            color: context.colors.fieldBorder.withOpacity(.4),
                          ),

                          _StatItem(
                            icon: Icons.pending_actions_outlined,
                            label: 'team_details.pending_tasks'.tr(),
                            value: teamDetails.pendingTasksCount.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ==========================================
                // Projects section header
                // ==========================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    'team_details.projects'.tr(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: context.colors.darkBlue,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ==========================================
                // Projects list
                // ==========================================
                Obx(() {
                  // Loading.
                  if (controller.isProjectsLoading.value &&
                      controller.projects.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: context.colors.darkBlue,
                        ),
                      ),
                    );
                  }

                  // Error.
                  if (controller.hasProjectsError.value &&
                      controller.projects.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.projectsErrorMessage.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: context.colors.darkBlue,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 12),

                          ElevatedButton(
                            onPressed: controller.fetchProjects,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Empty.
                  if (controller.projects.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.folder_off_outlined,
                              size: 36,
                              color: context.colors.fieldBorder,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "No projects available",
                              style: TextStyle(
                                color: context.colors.fieldBorder,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Projects list.
                  return Column(
                    children: controller.projects
                        .map(
                          (project) => ProjectCard(
                            project: project,
                            onTap: () => Get.toNamed(
                              Pages.projectDetails.value,
                              arguments: ProjectDetailsPageNav(
                                teamId: nav.id,
                                projectId: project.id,
                              ),
                            ),
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

  // ==========================================
  // Leave team confirmation dialog
  // ==========================================
  void _confirmLeaveTeam(
    BuildContext context,
    TeamDetailsPageController controller,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: dialogContext.colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'team_details.leave_team'.tr(),
          style: TextStyle(
            color: dialogContext.colors.darkBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'team_details.leave_team_confirmation'.tr(),
          style: TextStyle(
            color: dialogContext.colors.fieldBorder,
            fontSize: 13,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'common.cancel'.tr(),
              style: TextStyle(color: dialogContext.colors.darkBlue),
            ),
          ),
          Obx(
            () => TextButton(
              onPressed: controller.isLeavingTeam.value
                  ? null
                  : () async {
                      Get.back(); // اقفل الـ dialog
                      await controller.leaveTeam();
                    },
              child: controller.isLeavingTeam.value
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: dialogContext.colors.darkBlue,
                      ),
                    )
                  : Text(
                      'team_details.leave'.tr(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// Small stat widget (score / pending tasks)
// ==========================================
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: context.colors.darkBlue,
        ),

        const SizedBox(height: 6),

        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: context.colors.darkBlue,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: context.colors.fieldBorder,
          ),
        ),
      ],
    );
  }
}