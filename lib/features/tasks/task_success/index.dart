import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:task_management_app/core/routes/routes.dart';
import 'package:task_management_app/core/widgets/auth_background/auth_background.dart';
import 'package:task_management_app/features/app/main/controller.dart/controller.dart';
import 'package:task_management_app/features/app/main/models/destinations.dart';

import '../../../core/style/app_colors.dart';
import 'models/nav.dart';

class TaskSuccessPage extends StatelessWidget {
  const TaskSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskSuccessPageNav nav = Get.arguments as TaskSuccessPageNav;

    return AuthBackground(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "task_success.title".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              Text(
                "task_success.you_got_score".tr(args: [nav.score.toString()]),
                textAlign: TextAlign.center,
                style:  TextStyle(fontSize: 20, color: context.colors.darkBlue),
              ),
              const SizedBox(height: 16),
              Text(
                "task_success.continue_getting_scores".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: context.colors.black.withOpacity(.5)),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _goBackToTasks,
                child: Text(
                  "task_success.go_back_to_tasks".tr(),
                  style:  TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    color: context.colors.darkBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goBackToTasks() {
    Get.until((route) => route.settings.name == Pages.home.value);
    Get.find<MainPageController>().destination.value = HomeDestination.tasks;
  }
}