import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/features/notifications/contoller.dart';


import '../../core/style/app_colors.dart';
import 'widgets/notification_empty.dart';
import 'widgets/notification_error.dart';
import 'widgets/notification_list.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
   
  @override
  Widget build(BuildContext context) {
    final controller = Get.put( 
      
      NotificationsController(),
    );

    return Scaffold(
      backgroundColor: context.colors.white,

      appBar: AppBar(
        backgroundColor: context.colors.white,
        elevation: 0,

        centerTitle: true,

        title:  Text(
          'Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: context.colors.darkBlue,
          ),
        ),
      ),

      body: Obx(
        () {
          // Loading
          if (controller.isLoading.value &&
              controller.notifications.isEmpty) {
            return  Center(
              child: CircularProgressIndicator(
                color: context.colors.darkBlue,
              ),
            );
          }

          // Error
          if (controller.hasError.value &&
              controller.notifications.isEmpty) {
            return NotificationError(
              message: controller.errorMessage.value,
              onRetry: controller.loadNotifications,
            );
          }

          // Empty
          if (controller.notifications.isEmpty) {
            return RefreshIndicator(
              onRefresh: controller.refreshNotifications,
              child: const NotificationEmpty(),
            );
          }

          // Notifications
          return RefreshIndicator(
            onRefresh: controller.refreshNotifications,
            child: NotificationList(
              notifications: controller.notifications,
            ),
          );
        },
      ),
    );
  }
}