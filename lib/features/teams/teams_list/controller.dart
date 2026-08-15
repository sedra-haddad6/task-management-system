import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:task_management_app/core/services/rest_api/rest_api.dart';

class TeamsListPageController extends GetxController {
  Future<ResponseModel> fetchTeams(int page, CancelToken cancel) async {
    
    //TODO WhEn THE api ready 

    // ============================================================
    // return await APIService.instance.request(
    //   Request(
    //     endPoint: EndPoints.teams, // 
    //     params: {"page": page},
    //     cancelToken: cancel,
    //   ),
    // );

    
    //  بيانات وهمية مؤقتة
    
    await Future.delayed(const Duration(milliseconds: 400));

    if (page > 1) {
      return ResponseModel(success: true, message: "", data: []);
    }

    return ResponseModel(
      success: true,
      message: "",
      data: [
        {"id": 1, "name": "IT team", "pending_tasks_count": 2},
        {"id": 2, "name": "Team name", "pending_tasks_count": 0},
        {"id": 3, "name": "The team's name", "pending_tasks_count": 5},
        {"id": 4, "name": "IT team", "pending_tasks_count": 1},
      ],
    );
  }
}