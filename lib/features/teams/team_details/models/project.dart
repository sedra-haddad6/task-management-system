class Project {
  final int id;
  final int teamId;
  final String title;
  final String? description;
  final String status;
  final String? startDate;
  final String? endDate;

  Project({
    required this.id,
    required this.teamId,
    required this.title,
    this.description,
    required this.status,
    this.startDate,
    this.endDate,
  });

  factory Project.fromJson(
    Map<String, dynamic> json,
  ) {
    return Project(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(
                json['id']?.toString() ?? '',
              ) ??
              0,

      teamId: json['team_id'] is int
          ? json['team_id']
          : int.tryParse(
                json['team_id']?.toString() ?? '',
              ) ??
              0,

      title: json['title']?.toString() ?? '',

      description:
          json['description']?.toString(),

      status:
          json['status']?.toString() ?? 'pending',

      startDate:
          json['start_date']?.toString(),

      endDate:
          json['end_date']?.toString(),
    );
  }
}