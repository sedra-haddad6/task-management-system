import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/app_builder.dart';
import '../../../core/config/roles.dart';
import '../../../core/services/rest_api/rest_api.dart';
import '../../../core/widgets/loading/loading.dart';

class SignupPageController extends GetxController {
  final AppBuilder appBuilder = Get.find();
final role = 'member'.obs;
  final formKey = GlobalKey<FormState>();

  late TextEditingController name, email, password, confirmPassword;

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;

    Loading.show();

    // TODO - عبّي الـ endPoint 
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.baseUrl, // placeholder لحد ما تتحدد EndPoints.signup
        method: RequestMethod.post,
        body: {
          "name": name.text,
          "email": email.text,
          "password": password.text,
        },
      ),
    );

    Loading.close();

    if (response.success) {
      appBuilder.setToken(response.data?['access_token']);
      appBuilder.setRole(Roles.registeredUser);
      Get.offAllNamed(appBuilder.role.landingPage.value);
    } else {
      Get.snackbar("", response.message);
    }
  }

  void goToLogin() {
    Get.back();
  }
}