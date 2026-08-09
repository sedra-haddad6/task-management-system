import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import '../../home/index.dart';
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
          //TODO بس نعمل باقي الصفحات 
HomeDestination.teams => HomePage(label: "home.teams".tr()),
  HomeDestination.tasks => HomePage(label: "home.tasks".tr()),
  HomeDestination.notifications => HomePage(label: "home.notifications".tr()),
  HomeDestination.profile => HomePage(label: "home.profile".tr()),
        },
      ), )
    );
  }
}