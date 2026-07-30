import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/rest_api/rest_api.dart';
import '../../../core/widgets/loading/loading.dart';

class JoinTeamController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late TextEditingController teamCode;

  @override
  void onInit() {
    teamCode = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    teamCode.dispose();
    super.onClose();
  }

  Future<void> joinTeam() async {
    if (!formKey.currentState!.validate()) return;

    Loading.show();

    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.joinTeam,
        method: RequestMethod.post,
        body: {
          "join_code": teamCode.text.trim(),
        },
      ),
    );

    Loading.close();

    if (response.success) {
      Get.snackbar(
        "Success",
        response.message,
      );

      teamCode.clear();

      // إذا أردتِ الانتقال لواجهة الفريق بعد الانضمام
      // Get.offAllNamed(AppRoutes.teamHome);
    } else {
      Get.snackbar(
        "Error",
        response.message,
      );
    }
  }
}