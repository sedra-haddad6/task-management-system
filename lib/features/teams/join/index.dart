import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import '../../../core/widgets/auth_background/auth_background.dart';
import '../../../core/widgets/buttons/elevated_button.dart';
import '../../../core/widgets/fields/app_text_field.dart';
import 'controller.dart';

class JoinTeamPage extends StatelessWidget {
  const JoinTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JoinTeamController());

    return AuthBackground(
      showBackButton: true,
      child: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 60,
          ),
          children: [

            const SizedBox(height: 70),

            AppTextField(
              controller: controller.teamCode,
              hint: "join_team.code_hint".tr(),
              prefixIcon: Icon(Icons.security),
            ),

            const SizedBox(height: 35),

            AppElevatedButton(
              onPressed: controller.joinTeam,
              child: Text("join_team.button".tr()),
            ),

            const SizedBox(height: 50),

             Center(
              child: Text(
                "join_team.pending_message".tr(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}