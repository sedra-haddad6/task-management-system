import 'package:get/get.dart';

import '../../core/services/rest_api/rest_api.dart';
import 'models/notification.dart';

class NotificationsController extends GetxController {
  final notifications = <AppNotification>[].obs;

  final isLoading = false.obs;

  final hasError = false.obs;

  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    loadNotifications();
  }

  Future<void> loadNotifications() async {
    isLoading.value = true;
    hasError.value = false;

    final ResponseModel response =
        await APIService.instance.request(
      Request(
        endPoint: EndPoints.notifications,
        method: RequestMethod.get,
      ),
    );

    isLoading.value = false;

    if (response.success) {
      final data = response.data;

      if (data is List) {
        notifications.assignAll(
          data
              .whereType<Map<String, dynamic>>()
              .map(
                (json) => AppNotification.fromJson(json),
              )
              .toList(),
        );
      } else if (data is Map<String, dynamic>) {
        final list = data['notifications'];

        if (list is List) {
          notifications.assignAll(
            list
                .whereType<Map<String, dynamic>>()
                .map(
                  (json) =>
                      AppNotification.fromJson(json),
                )
                .toList(),
          );
        }
      }
    } else {
      hasError.value = true;
      errorMessage.value = response.message;
    }
  }

  Future<void> refreshNotifications() async {
    await loadNotifications();
  }

  Future<void> markAsRead(int notificationId) async {
    // سيتم ربطها بالـ backend عندما يعطينا الفريق endpoint
    // الخاص بتحديث حالة الإشعار.

    final index = notifications.indexWhere(
      (notification) => notification.id == notificationId,
    );

    if (index == -1) return;

    final oldNotification = notifications[index];

    notifications[index] = AppNotification(
      id: oldNotification.id,
      title: oldNotification.title,
      message: oldNotification.message,
      createdAt: oldNotification.createdAt,
      isRead: true,
    );
  }
}