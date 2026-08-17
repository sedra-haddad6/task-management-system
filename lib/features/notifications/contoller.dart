import 'dart:developer';

import 'package:get/get.dart';
import 'package:task_management_app/features/notifications/services/rest_api.dart';

import 'models/notification.dart';

class NotificationsController extends GetxController {
  final NotificationService service = NotificationService();

  final RxList<AppNotification> notifications =
      <AppNotification>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;

  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final response = await service.getNotifications();

      log(
        'Notifications response: ${response.toJson()}',
        name: 'NOTIFICATIONS',
      );

      if (!response.success) {
        _handleError(response.message);
        return;
      }

      final List<AppNotification> result =
          _parseNotifications(response.data);

      notifications.assignAll(result);
    } catch (e, stackTrace) {
      log(
        'Notifications error: $e',
        name: 'NOTIFICATIONS',
        stackTrace: stackTrace,
      );

      _handleError(
        'Unable to load notifications',
      );
    } finally {
      isLoading.value = false;
    }
  }

  List<AppNotification> _parseNotifications(dynamic data) {
    if (data == null) {
      return [];
    }

    /*
     * Case 1:
     *
     * data = [
     *   {...},
     *   {...}
     * ]
     */
    if (data is List) {
      return data
          .whereType<Map>()
          .map(
            (item) => AppNotification.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    }

    /*
     * Case 2:
     *
     * data = {
     *   "notifications": [...]
     * }
     */
    if (data is Map) {
      final notificationsData = data['notifications'];

      if (notificationsData is List) {
        return notificationsData
            .whereType<Map>()
            .map(
              (item) => AppNotification.fromJson(
                Map<String, dynamic>.from(item),
              ),
            )
            .toList();
      }

      /*
       * Case 3:
       *
       * data = {
       *   "data": [...]
       * }
       */
      final nestedData = data['data'];

      if (nestedData is List) {
        return nestedData
            .whereType<Map>()
            .map(
              (item) => AppNotification.fromJson(
                Map<String, dynamic>.from(item),
              ),
            )
            .toList();
      }
    }

    return [];
  }

  void _handleError(String message) {
    hasError.value = true;
    errorMessage.value =
        message.isEmpty ? 'Something went wrong' : message;
  }

  Future<void> refreshNotifications() async {
    await loadNotifications();
  }
}