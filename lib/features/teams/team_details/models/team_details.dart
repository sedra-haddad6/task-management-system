import '../../../tasks/models/task.dart';
import 'team_member.dart';

class TeamDetails {
  final int id;
  final String name;
  final String joinCode;

  final String managerName;
  final String? managerEmail;
  final String? managerProfileImage;

  final List<TeamMember> members;

  // Kept for the existing UI.
  // The current team endpoint does not provide these values.
  final int score;
  final int pendingTasksCount;
  final List<Task> tasks;

  TeamDetails({
    required this.id,
    required this.name,
    required this.joinCode,
    required this.managerName,
    this.managerEmail,
    this.managerProfileImage,
    required this.members,
    this.score = 0,
    this.pendingTasksCount = 0,
    this.tasks = const [],
  });

  factory TeamDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    final dynamic admin = json['admin'];
    final dynamic membersJson = json['members'];

    return TeamDetails(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(
                json['id']?.toString() ?? '',
              ) ??
              0,

      name: json['team_name']?.toString() ?? '',

      joinCode: json['join_code']?.toString() ?? '',

      managerName: admin is Map
          ? admin['name']?.toString() ?? ''
          : '',

      managerEmail: admin is Map &&
              admin['email'] != null
          ? admin['email'].toString()
          : null,

      managerProfileImage: admin is Map &&
              admin['profile_image'] != null
          ? admin['profile_image'].toString()
          : null,

      members: membersJson is List
          ? membersJson
              .whereType<Map>()
              .map(
                (member) => TeamMember.fromJson(
                  Map<String, dynamic>.from(member),
                ),
              )
              .toList()
          : [],

      score: 0,
      pendingTasksCount: 0,
      tasks: const [],
    );
  }
}