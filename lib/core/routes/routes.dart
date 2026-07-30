import 'package:get/get.dart';

import '../../features/app/splash/index.dart';
import '../../features/auth/login/index.dart';
import '../../features/auth/signup/index.dart';
import '../../features/teams/admin/index.dart';
import '../../features/teams/join/index.dart';

abstract class AppRouting {
  static GetPage initialRoute = GetPage(name: "/", page: () => SplashPage());

  static List<GetPage> pages = [
    initialRoute,
    ...Pages.values.map((page) => page.getPage),
  ];
}
//منضيف هون كل الصفحات الجديدة 
enum Pages {
  login,
  signup,
  joinTeam,
  webDashboard;

  String get value => "/$name";

  GetPage get getPage => switch (this) {
    login => GetPage(name: value, page: () => LoginPage()),
    signup => GetPage(name: value, page: () => SignupPage()),
    joinTeam => GetPage(name: value,page: () =>  JoinTeamPage()),
    // ignore: unreachable_switch_case
    webDashboard => GetPage(name: value,page: () =>  WebDashboardPage()),

  };
}