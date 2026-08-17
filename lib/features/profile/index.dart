import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/features/profile/widgets/statistic_section.dart';

import '../../core/config/app_builder.dart';


import '../../core/style/app_colors.dart';
import 'controller.dart';
import 'widgets/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProfilePageController(),
    );

    final AppBuilder appBuilder = Get.find<AppBuilder>();

    return Scaffold(
      backgroundColor: context.colors.white,

      body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(
              name: appBuilder.userName ?? "",
              email: appBuilder.userEmail ?? "",
              imageUrl: appBuilder.userImage,
            ),

            Container(
              height: 1,
              color: context.colors.grey,
            ),

            Expanded(
              child: Obx(
                () {
                  // Loading
                  if (controller.isLoading.value &&
                      controller.stats.value == null) {
                    return  Center(
                      child: CircularProgressIndicator(
                        color: context.colors.darkBlue,
                      ),
                    );
                  }

                  // Statistics successfully loaded
                  if (controller.stats.value != null) {
                    return ListView(
                      padding: const EdgeInsets.only(
                        top: 25,
                        bottom: 30,
                      ),
                      children: [
                        StatisticsSection(
                          stats: controller.stats.value!,
                        ),
                      ],
                    );
                  }

                  // API failed
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(
                          Icons.bar_chart_outlined,
                          size: 45,
                          color: context.colors.fieldBorder,
                        ),

                        const SizedBox(height: 12),

                         Text(
                          "Statistics are not available",
                          style: TextStyle(
                            color: context.colors.darkBlue,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 15),

                        TextButton(
                          onPressed: controller.loadProfileStats,
                          child: const Text(
                            "Try again",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}