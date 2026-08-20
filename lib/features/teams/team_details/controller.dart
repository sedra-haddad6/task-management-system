import 'package:get/get.dart';

import 'package:task_management_app/core/services/rest_api/rest_api.dart';
import 'package:task_management_app/core/services/state_management/obs.dart';

import 'models/nav.dart';
import 'models/team_details.dart';

class TeamDetailsPageController extends GetxController {
  final TeamDetailsPageNav nav;

  TeamDetailsPageController({
    required this.nav,
  });

  Obs<TeamDetails> teamDetails = Obs(null);

  @override
  void onInit() {
    super.onInit();

    fetchDetails();
  }

  Future<void> fetchDetails() async {
    // teamDetails.isLoading = true;

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

    // teamDetails.loading = false;
  }

  Future<void> refreshDetails() async {
    teamDetails.reset();

    await fetchDetails();
  }
}