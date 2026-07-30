import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              hint: "Enter the team code",
              prefixIcon: Icon(Icons.security),
            ),

            const SizedBox(height: 35),

            AppElevatedButton(
              onPressed: controller.joinTeam,
              child: const Text("Join Team"),
            ),

            const SizedBox(height: 50),

            const Center(
              child: Text(
                "Your request is in progress...",
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