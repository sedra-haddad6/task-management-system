import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                "Welcome Admin",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),

              const SizedBox(height: 18),

              const Text(
                "Your dashboard is available on the web.\n"
                "Use it to manage teams, members and tasks.",
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
                  child: const Text(
                    "Open Dashboard",
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
                        Text("Manage Teams"),
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
                        Text("Manage Tasks"),
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
                        Text("Manage Members"),
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
                        Text("View Reports"),
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