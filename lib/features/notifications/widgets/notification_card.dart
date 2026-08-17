import 'package:flutter/material.dart';


import '../../../core/style/app_colors.dart';
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
        color: context.colors.white,
        border: Border(
          bottom: BorderSide(
            color: context.colors.grey,
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
              color: context.colors.lightBlue,
              shape: BoxShape.circle,
            ),
            child:  Icon(
              Icons.notifications_none,
              color: context.colors.darkBlue,
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
                    color: context.colors.darkBlue,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  notification.message,
                  style:  TextStyle(
                    fontSize: 12,
                    color:context.colors.fieldBorder,
                  ),
                ),

                if (notification.createdAt != null) ...[
                  const SizedBox(height: 5),

                  Text(
                    notification.createdAt!,
                    style:  TextStyle(
                      fontSize: 10,
                      color: context.colors.fieldBorder,
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