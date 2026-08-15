import '../../models/task_step.dart';

class TaskDetails {
  int id;
  String name;
  String deadline;
  String teamName;
  String assignedByName;
  String assignedToName;
  List<TaskStep> steps;

  TaskDetails({
    required this.id,
    required this.name,
    required this.deadline,
    required this.teamName,
    required this.assignedByName,
    required this.assignedToName,
    required this.steps,
  });

  factory TaskDetails.fromJson(Map<String, dynamic> json) => TaskDetails(
    id: json["id"],
    name: json["name"],
    deadline: json["deadline"],
    teamName: json["team_name"],
    assignedByName: json["assigned_by_name"],
    assignedToName: json["assigned_to_name"],
    steps: List<TaskStep>.from(
      (json["steps"] as List).map((s) => TaskStep.fromJson(s)),
    ),
  );

  bool get allStepsChecked => steps.every((step) => step.isChecked);

  int get checkedStepsCount => steps.where((step) => step.isChecked).length;
}