import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import '../../../core/widgets/auth_background/auth_background.dart';
import 'controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashPageController());

    return AuthBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
             "splash.welcome_to".tr(),
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "splash.tagline".tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 34,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}