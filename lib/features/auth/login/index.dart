import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import '../../../core/utils/validator.dart';
import '../../../core/widgets/auth_background/auth_background.dart';
import '../../../core/widgets/buttons/elevated_button.dart';
import '../../../core/widgets/fields/app_text_field.dart';
import 'controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginPageController());

    return AuthBackground(
      child: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 60,
          ),
          children: [
            const SizedBox(height: 35),

            Center(
              child: Text(
                 "login.title".tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            const SizedBox(height: 50),

            AppTextField(
              controller: controller.email,
              hint:"login.email_hint".tr(),
              keyboardType: TextInputType.emailAddress,
              validator: Validator.validateEmail,
              prefixIcon: const Icon(Icons.mail_outline),
            ),

            const SizedBox(height: 20),

            AppTextField(
              controller: controller.password,
              hint:  "login.password_hint".tr(),
              isPassword: true,
              validator: Validator.validatePassword,
              prefixIcon: const Icon(Icons.lock_outline),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: 220,
              child: AppElevatedButton(
                 onPressed: () => controller.login(),
                child:  Text("login.login_button".tr()),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("login.no_account".tr()),
                TextButton(
                  onPressed: controller.goToSignup,
                  child:  Text("login.signup_link".tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}