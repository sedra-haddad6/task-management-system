import 'package:flutter/material.dart';

import '../../../core/style/repo.dart';

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
            const Icon(
              Icons.error_outline,
              size: 50,
              color: StyleRepo.error,
            ),

            const SizedBox(height: 15),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: StyleRepo.darkBlue,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: onRetry,
              child: const Text(
                'Try again',
              ),
            ),
          ],
        ),
      ),
    );
  }
}