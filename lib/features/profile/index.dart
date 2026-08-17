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
    final controller = Get.put(ProfilePageController());

    final AppBuilder appBuilder = Get.find<AppBuilder>();

    return Scaffold(
      backgroundColor: context.colors.white,

      body: SafeArea(
        child: Obx(
          () {
            final stats = controller.stats.value;

            return Column(
              children: [
                ProfileHeader(
                  name: appBuilder.userName ?? "User",
                  email: appBuilder.userEmail ?? "",
                  imageUrl: appBuilder.userImage,
                ),

                Container(
                  height: 1,
                  color: context.colors.grey,
                ),

                Expanded(
                  child: controller.isLoading.value && stats == null
                      ?  Center(
                          child: CircularProgressIndicator(
                           color: context.colors.darkBlue,
                          ),
                        )
                      : stats == null
                          ? const Center(
                              child: Text(
                                "No statistics available",
                              ),
                            )
                          : ListView(
                              padding: const EdgeInsets.only(
                                top: 25,
                                bottom: 30,
                              ),
                              children: [
                                StatisticsSection(
                                  stats: stats,
                                ),
                              ],
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}