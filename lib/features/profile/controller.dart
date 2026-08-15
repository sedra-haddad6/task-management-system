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
    isLoading.value = true;

    final ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.profileStats,
        method: RequestMethod.get,
      ),
    );

    isLoading.value = false;

    if (response.success) {
      stats.value = ProfileStats.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    } else {
      Get.snackbar(
        "",
        response.message,
      );
    }
  }
}