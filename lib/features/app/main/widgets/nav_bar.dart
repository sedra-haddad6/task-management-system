import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/style/repo.dart';
import '../controller.dart/controller.dart';
import '../models/destinations.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainPageController>();

    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: StyleRepo.green,
        selectedItemColor: StyleRepo.darkBlue,
        unselectedItemColor: StyleRepo.black.withOpacity(.4),
        currentIndex: controller.destination.value.index,
        onTap: (index) =>
            controller.destination.value = HomeDestination.values[index],
        items: HomeDestination.values.map((destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            label: "",
          );
        }).toList(),
      ),
    );
  }
}