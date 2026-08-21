import 'package:get/get.dart';

import 'package:task_management_app/core/services/rest_api/rest_api.dart';
import 'package:task_management_app/core/services/state_management/obs.dart';
import 'package:task_management_app/features/teams/models/project.dart';

import 'models/nav.dart';
import 'models/team_details.dart';

class TeamDetailsPageController extends GetxController {
  final TeamDetailsPageNav nav;

  TeamDetailsPageController({
    required this.nav,
  });

  //=========================================
  // Team
  //=========================================

  final Obs<TeamDetails> teamDetails =
      Obs(null);

  //=========================================
  // Projects
  //=========================================

  final RxList<Project> projects =
      <Project>[].obs;

  final RxBool isProjectsLoading =
      false.obs;

  final RxBool hasProjectsError =
      false.obs;

  final RxString projectsErrorMessage =
      ''.obs;

  @override
  void onInit() {
    super.onInit();

    fetchDetails();
    fetchProjects();
  }

  //=========================================
  // Fetch Team Details
  //=========================================

  Future<void> fetchDetails() async {
    final ResponseModel response =
        await APIService.instance.request(
      Request<TeamDetails>(
        endPoint: EndPoints.team(nav.id),
        method: RequestMethod.get,
        fromJson: TeamDetails.fromJson,
      ),
    );

    if (response.success) {
      teamDetails.data = response.data;
    } else {
      teamDetails.error = response.message;
    }
  }

  //=========================================
  // Fetch Team Projects
  //=========================================

  Future<void> fetchProjects() async {
    isProjectsLoading.value = true;
    hasProjectsError.value = false;

    final ResponseModel response =
        await APIService.instance.request(
      Request(
        endPoint: EndPoints.projects(nav.id),
        method: RequestMethod.get,
      ),
    );

    if (!response.success) {
      hasProjectsError.value = true;
      projectsErrorMessage.value =
          response.message;
      isProjectsLoading.value = false;
      return;
    }

    try {
      final dynamic data = response.data;

      List<dynamic> projectsJson = [];

      if (data is Map<String, dynamic>) {
        final dynamic list = data['projects'];

        if (list is List) {
          projectsJson = list;
        }
      } else if (data is List) {
        projectsJson = data;
      }

      projects.value = projectsJson
          .whereType<Map>()
          .map(
            (json) => Project.fromJson(
              Map<String, dynamic>.from(json),
            ),
          )
          .toList();

      hasProjectsError.value = false;
    } catch (e) {
      hasProjectsError.value = true;
      projectsErrorMessage.value =
          e.toString();
    } finally {
      isProjectsLoading.value = false;
    }
  }

  //=========================================
  // Refresh
  //=========================================

  Future<void> refreshDetails() async {
    teamDetails.reset();
    projects.clear();

    await Future.wait([
      fetchDetails(),
      fetchProjects(),
    ]);
  }
}