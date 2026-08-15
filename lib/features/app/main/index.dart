import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:task_management_app/features/notifications/index.dart';

import '../../home/index.dart';
import '../../tasks/tasks_list/index.dart';
import '../../teams/teams_list/index.dart';
import 'controller.dart/controller.dart';
import 'models/destinations.dart';
import 'widgets/nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainPageController());

    return Scaffold(
  
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(       
    child: Obx(
        () => switch (controller.destination.value) {
          HomeDestination.home => const HomePage(),
          HomeDestination.teams => const TeamsListPage(),
          HomeDestination.tasks => const TasksListPage(),
          HomeDestination.notifications => const NotificationsPage(),
          //TODO بس نعمل باقي الصفحات 

  HomeDestination.notifications => HomePage(label: "home.notifications".tr()),
  HomeDestination.profile => HomePage(label: "home.profile".tr()),
        },
      ), )
    );
  }
}