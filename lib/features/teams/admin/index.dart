import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widgets/buttons/elevated_button.dart';
import 'controller.dart';

class WebDashboardPage extends StatelessWidget {
  const WebDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(WebDashboardController());

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

               Icon(
                Icons.laptop_mac_rounded,
                size: 90,
                color: context.colors.darkBlue,
              ),

              const SizedBox(height: 35),

              Text(
                'admin.welcome'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),

              const SizedBox(height: 18),

               Text(
                'admin.dashboard_description'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 45),

              SizedBox(
                width: double.infinity,

                child: AppElevatedButton(
                  onPressed: controller.openDashboard,
                  child:  Text(
                    'admin.open_dashboard'.tr(),
                  ),
                ),
              ),

              const SizedBox(height: 45),

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: context.colors.lightBlue,
                  borderRadius: BorderRadius.circular(20),
                ),

                child:  Column(
                  children: [

                    Row(
                      children: [
                        Icon(
                          Icons.groups_outlined,
                          color: context.colors.darkBlue,
                        ),
                        SizedBox(width: 10),
                        Text('admin.manage_teams'.tr()),
                      ],
                    ),

                    SizedBox(height: 12),

                    Row(
                      children: [
                        Icon(
                          Icons.task_alt,
                          color: context.colors.darkBlue,
                        ),
                        SizedBox(width: 10),
                        Text('admin.manage_tasks'.tr()),
                      ],
                    ),

                    SizedBox(height: 12),

                    Row(
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          color: context.colors.darkBlue,
                        ),
                        SizedBox(width: 10),
                        Text('admin.manage_members'.tr()),
                      ],
                    ),

                    SizedBox(height: 12),

                    Row(
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          color: context.colors.darkBlue,
                        ),
                        SizedBox(width: 10),
                        Text('admin.view_reports'.tr()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}