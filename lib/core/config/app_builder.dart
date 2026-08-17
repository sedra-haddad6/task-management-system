import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/loading/loading.dart';
import 'roles.dart';
import '../routes/routes.dart';
import '../services/rest_api/rest_api.dart';

const String kStorageApp = "app_1";

class AppBuilder extends GetxService {
  final GetStorage _box = GetStorage(kStorageApp);

  late Roles role;
  String? token;

  Map<String, dynamic>? user;

  // ================= USER DATA =================

  String? get userId => user?['id']?.toString();

  String? get userName => user?['name'];

  String? get userEmail => user?['email'];

  String? get userImage => user?['profile_image'];

  // ================= ROLE =================

  void setRole(Roles role) {
    _box.write("role", role.value);
    this.role = role;
  }

  // ================= TOKEN =================

  void setToken(String? token) {
    if (token == null) {
      _box.remove("token");
    } else {
      _box.write("token", token);
    }

    this.token = token;

    APIService.instance.setToken(token);
  }

  // ================= USER =================

  void setUser(Map<String, dynamic>? user) {
    this.user = user;

    if (user == null) {
      _box.remove("user");
    } else {
      _box.write("user", jsonEncode(user));
    }
  }

  // ================= LOAD DATA =================

  Future<void> _loadUserData() async {
    await _box.initStorage;

    role = Roles.fromString(
      _box.read("role"),
    );

    token = _box.read("token");

    final savedUser = _box.read("user");

    if (savedUser != null) {
      try {
        if (savedUser is String) {
          user = Map<String, dynamic>.from(
            jsonDecode(savedUser),
          );
        } else if (savedUser is Map) {
          user = Map<String, dynamic>.from(savedUser);
        }
      } catch (e) {
        log(
          "Failed to load saved user: $e",
          name: "APP BUILDER",
        );
      }
    }

    log(
      "User: $user",
      name: "APP BUILDER",
    );

    log(
      "Role: $role",
      name: "APP BUILDER",
    );
  }

  // ================= LOGOUT =================

Future<void> logout() async {
  Loading.show();

  ResponseModel response = await APIService.instance.request(
    Request(
      endPoint: EndPoints.logout,
      method: RequestMethod.post,
    ),
  );

  Loading.close();

  if (!response.success) {
    Get.snackbar("", response.message);
    return;
  }

  setRole(Roles.unregisteredUser);
  setToken(null);
  setUser(null);

  Get.offAllNamed(
    role.landingPage.value,
  );
}

  // ================= INIT =================

  Future<void> init() async {
    await _loadUserData();

    Get.put(
      APIService(
        token: token,
        language: EasyLocalization.of(
          Get.context!,
        )!.currentLocale!.languageCode,
      ),
    );

    Get.offAllNamed(
      role.landingPage.value,
    );
  }
}