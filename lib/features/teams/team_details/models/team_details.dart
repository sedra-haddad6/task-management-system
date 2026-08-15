import 'package:task_management_app/features/tasks/models/task.dart';

class TeamDetails {
  int id;
  String name;
  String managerName;
  int score;
  int pendingTasksCount;
  List<Task> tasks;

  TeamDetails({
    required this.id,
    required this.name,
    required this.managerName,
    required this.score,
    required this.pendingTasksCount,
    required this.tasks,
  });

  factory TeamDetails.fromJson(Map<String, dynamic> json) => TeamDetails(
    id: json["id"],
    name: json["name"],
    managerName: json["manager_name"],
    score: json["score"],
    pendingTasksCount: json["pending_tasks_count"] ?? 0,
    tasks: List<Task>.from(
      (json["tasks"] as List).map((taskJson) => Task.fromJson(taskJson)),
    ),
  );
}