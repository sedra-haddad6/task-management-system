
import 'package:get/get.dart';

import '../../../core/config/app_builder.dart';

class SplashPageController extends GetxController {

  Future<void> init() async {
    
    await Future.wait([
      Get.put(AppBuilder()).init(),  // بينققرأ role/token هون
      Future.delayed(const Duration(seconds: 3)), 
    ]);
  }


  @override
  void onInit() {
    init();
    super.onInit();
  }
}