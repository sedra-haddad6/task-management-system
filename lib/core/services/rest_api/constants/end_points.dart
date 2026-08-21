

// abstract class EndPoints {
//   //##########  Base Url  ##########    static const String baseUrl = 'http://192.168.1.5:8000/api'; للموبايل

  

//   static const String baseUrl = 'http://127.0.0.1:8000/api';

//   //SECTION - Auth

  
//   static const String login = "/auth/login";
//   static const String signup = "/auth/register";
//   static const String logout = "/auth/logout";
//   //!SECTION
// }



abstract class EndPoints {
  //=========================================
  // Base URL
  //=========================================

  // Android Emulator
  // static const String baseUrl = 'http://10.0.2.2:8000/api';

  // Real Device
  // static const String baseUrl = 'http://192.168.1.5:8000/api';

  // Flutter Web / Desktop
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  //=========================================
  // Auth
  //=========================================

  static const String login = "/auth/login";
  static const String signup = "/auth/register";
  static const String logout = "/auth/logout";
  static const String logoutAll = "/auth/logout-all";
  static const String me = "/auth/me";
  static const profileStats = "/user/statistics";
  static const notifications = "/notifications"; 
  //=========================================
  // Teams
  //=========================================

  static const String teams = "/teams";
  static const String joinTeam = "/teams/join";

  static String team(int teamId) => "/teams/$teamId";

  static String leaveTeam(int teamId) =>
      "/teams/$teamId/leave";

  //=========================================
  // Team Members
  //=========================================

  static String members(int teamId) =>
      "/teams/$teamId/members";

  static String removeMember(
    int teamId,
    int memberId,
  ) =>
      "/teams/$teamId/members/$memberId";

  //=========================================
  // Projects
  //=========================================

  static String projects(int teamId) =>
      "/teams/$teamId/projects";

  static String project(
    int teamId,
    int projectId,
  ) =>
      "/teams/$teamId/projects/$projectId";

  static String projectTasks(
  int teamId,
  int projectId,
) =>
    "/teams/$teamId/projects/$projectId/tasks";    

//=========================================
  // Tasks
  //=========================================

  static const String tasks = "/tasks";

  static String task(int taskId) => "/tasks/$taskId";

  static String completeTask(int taskId) => "/tasks/$taskId/complete";


}