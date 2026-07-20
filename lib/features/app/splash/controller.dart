
import 'package:get/get.dart';

import '../../../core/config/app_builder.dart';

class SplashPageController extends GetxController {
  Future<void> init() async {
    // بيقرأ role/token هون 
    await Get.put(AppBuilder()).init();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}