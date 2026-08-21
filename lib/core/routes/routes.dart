import 'package:get/get.dart';
import 'package:task_management_app/features/notifications/index.dart';
import 'package:task_management_app/features/profile/index.dart';

import 'package:task_management_app/features/timer/index.dart';


import '../../features/app/main/index.dart';

import '../../features/app/splash/index.dart';
import '../../features/auth/login/index.dart';
import '../../features/auth/signup/index.dart';
import '../../features/tasks/task_details/index.dart';
import '../../features/tasks/task_success/index.dart';
import '../../features/teams/admin/index.dart';
import '../../features/teams/join/index.dart';
import '../../features/teams/project_details/index.dart';
import '../../features/teams/team_details/index.dart';

abstract class AppRouting {
  static GetPage initialRoute = GetPage(name: "/", page: () => SplashPage());

  static List<GetPage> pages = [
    initialRoute,
    ...Pages.values.map((page) => page.getPage),
  ];
}

enum Pages {
  login,
  signup,
  home,
  joinTeam,
  webDashboard,

  // timer,
  
  notifications,
  teamDetails,
  projectDetails,   
  taskDetails,   
  taskSuccess,
  
  profile;

  String get value => "/$name";

  GetPage get getPage => switch (this) {
    login => GetPage(name: value, page: () => LoginPage()),
    signup => GetPage(name: value, page: () => SignupPage()),
    home => GetPage( name: value,  page: () => MainPage(),),
      profile => GetPage(
    name: value,
    page: () => ProfilePage(),
  ),
    notifications => GetPage(name: value, page: ()=>NotificationsPage()),
    joinTeam => GetPage(name: value,page: () =>  JoinTeamPage()),
    // ignore: unreachable_switch_case
    webDashboard => GetPage(name: value,page: () =>  WebDashboardPage()),

    // timer => GetPage(name: value, page: ()=> TimerPage()),
    teamDetails => GetPage(name: value, page: () => TeamDetailsPage()), 
    projectDetails => GetPage(name: value, page: () => ProjectDetailsPage()),
    taskDetails => GetPage(name: value, page: () => TaskDetailsPage()),   
    taskSuccess => GetPage(name: value, page: () => TaskSuccessPage()),


  };
}