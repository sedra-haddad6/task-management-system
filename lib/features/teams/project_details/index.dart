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

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailsPageNav nav = Get.arguments as ProjectDetailsPageNav;


    final ProjectDetailsPageController controller = Get.put(
      ProjectDetailsPageController(nav: nav),
      tag: nav.projectId.toString(),
    );

    return ObsBuilder(
      obs: controller.projectDetails,
      loadingBuilder: (context) =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      errorBuilder: (context, error) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(error)),
      ),
      builder: (context, projectDetails) {
        return Scaffold(
          appBar: AppBar(title: Text(projectDetails.title)),
          body: RefreshIndicator(
            onRefresh: controller.refreshDetails,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Center(
                  child: Text(
                    projectDetails.status,
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colors.black.withOpacity(.5),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (projectDetails.tasks.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text("project_details.no_tasks".tr()),
                    ),
                  )
                else
                  ...projectDetails.tasks.map(
                    (task) => TaskCard(
                      task: task,
                      onTap: () => Get.toNamed(
                        Pages.taskDetails.value,
                        arguments: TaskDetailsPageNav(task.id),
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