import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../style/app_colors.dart';

abstract class Loading {
  static void show() {
    final appColors = Get.theme.extension<AppColors>()!;

    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: appColors.darkBlue,
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void close() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}