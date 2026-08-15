import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/features/notifications/contoller.dart';

import '../../core/style/repo.dart';
import 'models/notification.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller =
        Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: StyleRepo.white,

      appBar: AppBar(
        backgroundColor: StyleRepo.white,
        elevation: 0,

        centerTitle: true,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: StyleRepo.darkBlue,
          ),
        ),

        title: Text(
          "Notifications",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: StyleRepo.darkBlue,
          ),
        ),
      ),

      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: StyleRepo.darkBlue,
              ),
            );
          }

          if (controller.hasError.value) {
            return _ErrorState(
              message: controller.errorMessage.value,
              onRetry: controller.loadNotifications,
            );
          }

          if (controller.notifications.isEmpty) {
            return const _EmptyNotifications();
          }

          return RefreshIndicator(
            color: StyleRepo.darkBlue,

            onRefresh: controller.refreshNotifications,

            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.fromLTRB(
                20,
                12,
                20,
                30,
              ),

              itemCount: controller.notifications.length,

              separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),

              itemBuilder: (context, index) {
                final notification =
                    controller.notifications[index];

                return NotificationCard(
                  notification: notification,
                  onTap: () {
                    controller.markAsRead(
                      notification.id,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}


// ================================================================
// NOTIFICATION CARD
// ================================================================

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: notification.isRead
              ? StyleRepo.white
              : StyleRepo.lightBlue,

          borderRadius: BorderRadius.circular(22),

          border: Border.all(
            color: StyleRepo.fieldBorder.withOpacity(.25),
          ),

          boxShadow: [
            BoxShadow(
              color: StyleRepo.darkBlue.withOpacity(.05),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Notification icon
            Container(
              width: 48,
              height: 48,

              decoration: const BoxDecoration(
                color: StyleRepo.white,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.notifications_none_rounded,
                color: StyleRepo.middleBlue,
                size: 25,
              ),
            ),

            const SizedBox(width: 13),

            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Expanded(
                        child: Text(
                          notification.title,

                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                notification.isRead
                                    ? FontWeight.w600
                                    : FontWeight.bold,
                            color: StyleRepo.darkBlue,
                          ),
                        ),
                      ),

                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,

                          margin:
                              const EdgeInsets.only(
                            top: 5,
                            left: 8,
                          ),

                          decoration:
                              const BoxDecoration(
                            color: StyleRepo.middleBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    notification.message,

                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: StyleRepo.black,
                    ),
                  ),

                  if (notification.createdAt != null) ...[
                    const SizedBox(height: 8),

                    Text(
                      notification.createdAt!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: StyleRepo.fieldBorder,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ================================================================
// EMPTY STATE
// ================================================================

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Container(
              width: 90,
              height: 90,

              decoration: const BoxDecoration(
                color: StyleRepo.lightBlue,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.notifications_none_rounded,
                size: 45,
                color: StyleRepo.middleBlue,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "notifications.empty",

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: StyleRepo.darkBlue,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "notifications.empty_description",

              textAlign: TextAlign.center,

              style: const TextStyle(
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


// ================================================================
// ERROR STATE
// ================================================================

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.error_outline_rounded,
              size: 55,
              color: StyleRepo.error,
            ),

            const SizedBox(height: 15),

            Text(
              message,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 14,
                color: StyleRepo.darkBlue,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}