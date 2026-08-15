import 'package:get/get.dart';

import 'package:task_management_app/core/services/rest_api/rest_api.dart';
import 'package:task_management_app/core/services/state_management/obs.dart';
import 'package:task_management_app/features/tasks/models/task.dart';

import 'models/nav.dart';
import 'models/team_details.dart';

class TeamDetailsPageController extends GetxController {
  final TeamDetailsPageNav nav;

  TeamDetailsPageController({required this.nav});

  Obs<TeamDetails> teamDetails = Obs(null);

  @override
  void onInit() {
    fetchDetails();
    super.onInit();
  }

  Future<void> fetchDetails() async {
  
    //TODO when the api ready 
    
    // ResponseModel response = await APIService.instance.request(
    //   Request(
    //     endPoint: EndPoints.team(nav.id), //  
    //     fromJson: TeamDetails.fromJson,
    //   ),
    // );
    // if (response.success) {
    //   teamDetails.data = response.data;
    // } else {
    //   teamDetails.error = response.message;
    // }

    //  بيانات وهمية مؤقتة
    // ============================================================
    await Future.delayed(const Duration(milliseconds: 400));

    teamDetails.data = TeamDetails(
      id: nav.id,
      name: "IT Team",
      managerName: "Ahmad Hameed",
      score: 350,
      pendingTasksCount: 2,
      tasks: [
        Task(
          id: 1,
          name: "create and save folders",
          deadline: "22/5",
          teamName: "IT team",
          status: TaskStatus.pending,
        ),
        Task(
          id: 2,
          name: "work on flutter project",
          deadline: "22/5",
          teamName: "IT team",
          status: TaskStatus.inProgress,
        ),
      ],
    );
  }

  Future<void> refreshDetails() async {
    teamDetails.reset();
    await fetchDetails();
  }
}