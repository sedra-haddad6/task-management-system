import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'roles.dart';
import '../routes/routes.dart';
import '../services/rest_api/rest_api.dart';

const String kStorageApp = "app_1";

///  loads saved role/token, initializes the API service
/// then routes the user to لtإhe correct landing page
/// 
/// 
class AppBuilder extends GetxService {
  final GetStorage _box = GetStorage(kStorageApp);

  late Roles role;
  String? token;


//المعلومات الشخصية للمستخدم عامة لكل التطبيق 
  Map<String, dynamic>? user;

  String? get userName => user?['name'];

String? get userEmail => user?['email'];

String? get userImage => user?['profile_image'];



  void setRole(Roles role) {
    _box.write("role", role.value);
    this.role = role;
  }

  void setToken(String? token) {
    if (token == null) {
      _box.remove("token");
    } else {
      _box.write("token", token);
    }
    this.token = token;
    APIService.instance.setToken(token);
  }

  Future<void> _loadUserData() async {
    await _box.initStorage;
    role = Roles.fromString(_box.read("role"));
    token = _box.read("token");
    log(role.toString(), name: "APP BUILDER");
  }

  Future<void> logout() async {

    await APIService.instance.request(
    Request(
      endPoint: EndPoints.logout,
      method: RequestMethod.post,
    ),
  );
    setRole(Roles.unregisteredUser);
    setToken(null);
    Get.offAllNamed(role.landingPage.value);
  }

  Future<void> init() async {
    await _loadUserData();

    Get.put(
      APIService(
        token: token,
        language: EasyLocalization.of(Get.context!)!.currentLocale!.languageCode,
      ),
    );

    // TODO - أي تهيئة إضافية  بتنحط هون قبل التوجيه
    Get.offAllNamed(role.landingPage.value);
  }
}