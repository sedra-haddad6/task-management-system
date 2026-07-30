import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WebDashboardController extends GetxController {

  
  static const String dashboardUrl =
      "http://localhost:5173/";

  Future<void> openDashboard() async {
    final Uri url = Uri.parse(dashboardUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      Get.snackbar(
        "Error",
        "Unable to open dashboard.",
      );
    }
  }
}