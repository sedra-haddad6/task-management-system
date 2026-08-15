import 'package:get/get.dart';

import '../../../core/routes/routes.dart';

class HomePageController extends GetxController {
  static const List<String> _quoteKeys = [
    "home.quote_1",
    "home.quote_2",
    "home.quote_3",
  ];

  String get quoteKey => _quoteKeys[DateTime.now().weekday % _quoteKeys.length];

  static const List<String> _weekdaysShort = [
    "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun",
  ];

  String get formattedDate {
    final now = DateTime.now();
    final weekday = _weekdaysShort[now.weekday - 1];
    return "$weekday  ${now.day}/${now.month}/${now.year}";
  }

  RxBool hasTeam = false.obs;

  @override
  void onInit() {
    checkTeamStatus();
    super.onInit();
  }

  Future<void> checkTeamStatus() async {
    hasTeam.value = false; //   هاد مجربد تجريب   بحذفه لما يصير في  باك

    // TODO  مع الباك (لسا معلّق):
    // ResponseModel response = await APIService.instance.request(
    //   Request(endPoint: EndPoints.teams),
    // );
    // if (response.success) {
    //   hasTeam.value = (response.data as List).isNotEmpty;
    // }
  }

  Future<void> goToJoinTeam() async {
    await Get.toNamed(Pages.joinTeam.value);
  }
}