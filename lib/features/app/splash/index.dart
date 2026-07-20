import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              "Welcome to",
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Productive Life",
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