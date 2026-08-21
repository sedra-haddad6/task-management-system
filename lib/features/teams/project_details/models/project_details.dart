import 'package:task_management_app/features/tasks/models/task.dart';

class ProjectDetails {
  int id;
  String title;
  String status;
  List<Task> tasks;

  ProjectDetails({
    required this.id,
    required this.title,
    required this.status,
    required this.tasks,
  });
}