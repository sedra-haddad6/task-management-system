import 'dart:convert';

enum TaskStatus { pending, inProgress, done }

TaskStatus taskStatusFromString(String value) {
  switch (value) {
    case "done":
      return TaskStatus.done;
    case "in_progress":
      return TaskStatus.inProgress;
    default:
      return TaskStatus.pending;
  }
}

class Task {
  int id;
  String name;
  String deadline;
  String teamName;
  TaskStatus status;

  Task({
    required this.id,
    required this.name,
    required this.deadline,
    required this.teamName,
    required this.status,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    name: json["name"],
    deadline: json["deadline"],
    teamName: json["team_name"],
    status: taskStatusFromString(json["status"] ?? "pending"),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "deadline": deadline,
    "team_name": teamName,
    "status": status.name,
  };
}