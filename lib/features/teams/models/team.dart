import 'dart:convert';

class Team {
  int id;
  String name;
  int pendingTasksCount;

  Team({
    required this.id,
    required this.name,
    required this.pendingTasksCount,
  });

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    pendingTasksCount: json["pending_tasks_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pending_tasks_count": pendingTasksCount,
  };
}