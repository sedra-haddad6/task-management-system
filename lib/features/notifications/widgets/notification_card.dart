import 'package:flutter/material.dart';

import '../../../core/style/repo.dart';
import '../models/notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: StyleRepo.white,
        border: Border(
          bottom: BorderSide(
            color: StyleRepo.grey,
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: StyleRepo.lightBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none,
              color: StyleRepo.darkBlue,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: notification.isRead
                        ? FontWeight.w500
                        : FontWeight.bold,
                    color: StyleRepo.darkBlue,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  notification.message,
                  style: const TextStyle(
                    fontSize: 12,
                    color: StyleRepo.fieldBorder,
                  ),
                ),

                if (notification.createdAt != null) ...[
                  const SizedBox(height: 5),

                  Text(
                    notification.createdAt!,
                    style: const TextStyle(
                      fontSize: 10,
                      color: StyleRepo.fieldBorder,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}