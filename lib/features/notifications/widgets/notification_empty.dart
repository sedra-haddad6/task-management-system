import 'package:flutter/material.dart';

import '../../../core/style/repo.dart';

class NotificationEmpty extends StatelessWidget {
  const NotificationEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: StyleRepo.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none,
                size: 45,
                color: StyleRepo.darkBlue,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No notifications yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: StyleRepo.darkBlue,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'You will see your notifications here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: StyleRepo.fieldBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}