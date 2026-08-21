import 'package:task_management_app/features/tasks/models/task.dart';

class ProjectDetails {
  final int id;
  final String title;
  final String status;
  final List<Task> tasks;

  ProjectDetails({
    required this.id,
    required this.title,
    required this.status,
    required this.tasks,
  });
}