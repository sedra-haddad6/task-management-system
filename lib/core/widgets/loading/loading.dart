import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../style/repo.dart';

abstract class Loading {
  static void show() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(color: StyleRepo.darkBlue),
      ),
      barrierDismissible: false,
    );
  }

  static void close() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}