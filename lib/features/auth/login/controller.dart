import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/app_builder.dart';
import '../../../core/config/roles.dart';
import '../../../core/services/rest_api/rest_api.dart';
import '../../../core/widgets/loading/loading.dart';

class LoginPageController extends GetxController {
  final AppBuilder appBuilder = Get.find();

  final formKey = GlobalKey<FormState>();

  late TextEditingController email, password;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    Loading.show();

    // TODO - عبّي الـ endPoint من  البوستمان
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.baseUrl, // placeholder لحد ما تتحدد EndPoints.login
        method: RequestMethod.post,
        body: {"email": email.text, "password": password.text},
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

  void goToSignup() {
    Get.toNamed('/signup');
  }
}