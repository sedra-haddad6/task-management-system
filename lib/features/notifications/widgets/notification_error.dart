import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/style/app_colors.dart';



class NotificationError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const NotificationError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.error_outline,
              size: 50,
              color: context.colors.error,
            ),

            const SizedBox(height: 15),

            Text(
              message.tr(),
              textAlign: TextAlign.center,
              style:  TextStyle(
                color: context.colors.darkBlue,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: onRetry,
              child:  Text(
                'notifications.retry'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}