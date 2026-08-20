
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

  // These are kept for the existing UI.
  // The current /teams/{id} API does not provide them yet.
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

  factory TeamDetails.fromJson(Map<String, dynamic> json) {
    final admin = json['admin'];

    final membersJson = json['members'];

    return TeamDetails(
      id: json['id'] ?? 0,

      name: json['team_name'] ?? '',

      joinCode: json['join_code'] ?? '',

      managerName: admin is Map
          ? (admin['name'] ?? '')
          : '',

      managerEmail: admin is Map
          ? admin['email']?.toString()
          : null,

      managerProfileImage: admin is Map
          ? admin['profile_image']?.toString()
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

      // Not provided by the current endpoint.
      score: 0,
      pendingTasksCount: 0,
      tasks: [],
    );
  }
}