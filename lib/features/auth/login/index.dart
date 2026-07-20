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
                "Welcome Again",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            const SizedBox(height: 50),

            AppTextField(
              controller: controller.email,
              hint: "E-mail",
              keyboardType: TextInputType.emailAddress,
              validator: Validator.validateEmail,
              prefixIcon: const Icon(Icons.mail_outline),
            ),

            const SizedBox(height: 20),

            AppTextField(
              controller: controller.password,
              hint: "Password",
              isPassword: true,
              validator: Validator.validatePassword,
              prefixIcon: const Icon(Icons.lock_outline),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: 220,
              child: AppElevatedButton(
                onPressed: controller.login,
                child: const Text("Login"),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: controller.goToSignup,
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}