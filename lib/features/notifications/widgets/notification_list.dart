import 'package:flutter/material.dart';

import '../models/notification.dart';
import 'notification_card.dart';

class NotificationList extends StatelessWidget {
  final List<AppNotification> notifications;

  const NotificationList({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationCard(
          notification: notifications[index],
        );
      },
    );
  }
}