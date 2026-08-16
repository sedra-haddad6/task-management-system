import 'dart:developer';

import 'package:get/get.dart';
import 'package:task_management_app/features/profile/models/profile_state.dart';

import '../../core/services/rest_api/rest_api.dart';

class ProfilePageController extends GetxController {
  final Rxn<ProfileStats> stats = Rxn<ProfileStats>();

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadProfileStats();
  }

  Future<void> loadProfileStats() async {
    try {
      isLoading.value = true;

      final ResponseModel response =
          await APIService.instance.request(
        Request(
          endPoint: EndPoints.profileStats,
          method: RequestMethod.get,
        ),
      );

      // مهم جدًا لمعرفة ماذا يرجع الـBackend
      log(
        "Profile Stats Response: ${response.toJson()}",
        name: "PROFILE",
      );

      if (!response.success) {
        log(
          "Profile Stats Error: ${response.message}",
          name: "PROFILE",
        );

        return;
      }

      /*
       * Depending on backend response,
       * data may be:
       *
       * {
       *   completed_tasks: 6,
       *   ...
       * }
       *
       * OR:
       *
       * {
       *   data: {
       *      completed_tasks: 6,
       *      ...
       *   }
       * }
       */

      dynamic data = response.data;

      if (data is Map && data['data'] is Map) {
        data = data['data'];
      }

      if (data is Map) {
        stats.value = ProfileStats.fromJson(
          Map<String, dynamic>.from(data),
        );
      } else {
        log(
          "Invalid profile statistics data: $data",
          name: "PROFILE",
        );
      }
    } catch (e, stackTrace) {
      log(
        "Profile statistics exception: $e",
        name: "PROFILE",
        stackTrace: stackTrace,
      );
    } finally {
      isLoading.value = false;
    }
  }
}