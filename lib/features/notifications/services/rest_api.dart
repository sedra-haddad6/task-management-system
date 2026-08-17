import '../../../core/services/rest_api/rest_api.dart';
import '../models/notification.dart';

class NotificationService {
  Future<ResponseModel> getNotifications() {
    return APIService.instance.request(
      Request<List<AppNotification>>(
        endPoint: EndPoints.notifications,
        method: RequestMethod.get,
      ),
    );
  }
}