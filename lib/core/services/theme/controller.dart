import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const String kStorageTheme = "app_1";


class ThemeController extends GetxService {
  final GetStorage _box = GetStorage(kStorageTheme);

  final RxBool isDarkMode = false.obs;

  Future<ThemeController> init() async {
    await _box.initStorage;
    isDarkMode.value = _box.read("is_dark_mode") ?? false;
    return this;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _box.write("is_dark_mode", isDarkMode.value);

    // TODO لسا ما عم نبدل الألوان الفعلية هون

  }
}