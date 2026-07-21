import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:get/get.dart' hide Trans;

import '../../../core/utils/validator.dart';
import '../../../core/widgets/auth_background/auth_background.dart';
import '../../../core/widgets/buttons/elevated_button.dart';
import '../../../core/widgets/fields/app_text_field.dart';
import 'controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupPageController());

    return AuthBackground(
      child: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 40,
          ),
          children: [
            const SizedBox(height: 25),

            Center(
              child: Text(
                "signup.title".tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            const SizedBox(height: 40),

            AppTextField(
              controller: controller.name,
              hint: "signup.name_hint".tr(),
              validator: Validator.notNull,
              prefixIcon: const Icon(Icons.person_outline),
            ),

            const SizedBox(height: 18),

            AppTextField(
              controller: controller.email,
              hint: "signup.email_hint".tr(),
              keyboardType: TextInputType.emailAddress,
              validator: Validator.validateEmail,
              prefixIcon: const Icon(Icons.mail_outline),
            ),

            const SizedBox(height: 18),

            AppTextField(
              controller: controller.password,
              hint: "signup.password_hint".tr(),
              isPassword: true,
              validator: Validator.validatePassword,
              prefixIcon: const Icon(Icons.lock_outline),
            ),

            const SizedBox(height: 18),

            AppTextField(
              controller: controller.confirmPassword,
              hint: "signup.confirm_password_hint".tr(),
              isPassword: true,
              validator: Validator.validateConfirmPassword(
                controller.password,
              ),
              prefixIcon: const Icon(Icons.lock_outline),
            ),

            const SizedBox(height: 25),

            Text(
              "signup.select_role".tr(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            Obx(
              () => Column(
                children: [
                  RadioListTile<String>(
                    value: "member",
                    groupValue: controller.role.value,
                    onChanged: (value) {
                      controller.role.value = value!;
                    },
                    title: Text("signup.role_member".tr()),
                  ),
                  RadioListTile<String>(
                    value: "admin",
                    groupValue: controller.role.value,
                    onChanged: (value) {
                      controller.role.value = value!;
                    },
                   title: Text("signup.role_admin".tr()),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            AppElevatedButton(
              onPressed: () => controller.signup(),
             child: Text("signup.signup_button".tr()),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("signup.have_account".tr()),
                TextButton(
                  onPressed: controller.goToLogin,
                 child: Text("signup.login_link".tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}