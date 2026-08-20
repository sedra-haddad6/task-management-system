import 'package:get/get.dart';

import 'package:task_management_app/core/services/rest_api/rest_api.dart';

import '../models/team.dart';

class TeamsListPageController extends GetxController {
  final RxList<Team> teams = <Team>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    fetchTeams();
  }

  Future<void> fetchTeams() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final ResponseModel response =
          await APIService.instance.request(
        Request(
          endPoint: EndPoints.teams,
          method: RequestMethod.get,
        ),
      );

      if (!response.success) {
        hasError.value = true;
        errorMessage.value = response.message;
        return;
      }

      final data = response.data;

      if (data is Map<String, dynamic>) {
        final teamsData = data['teams'];

        if (teamsData is List) {
          teams.assignAll(
            teamsData
                .whereType<Map>()
                .map(
                  (json) => Team.fromJson(
                    Map<String, dynamic>.from(json),
                  ),
                )
                .toList(),
          );
        } else {
          teams.clear();
        }
      } else {
        teams.clear();
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTeams() async {
    await fetchTeams();
  }
}