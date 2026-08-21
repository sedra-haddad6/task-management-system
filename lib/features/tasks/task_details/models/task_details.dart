import '../../models/task_step.dart';

class TaskDetails {
  final int id;
  final String name;
  final String deadline;
  final String teamName;
  final String assignedByName;
  final String assignedToName;
  final List<TaskStep> steps;

  TaskDetails({
    required this.id,
    required this.name,
    required this.deadline,
    required this.teamName,
    required this.assignedByName,
    required this.assignedToName,
    required this.steps,
  });

  factory TaskDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    //=========================================
    // Team
    //=========================================

    String teamName = '';

    if (json['team_name'] != null) {
      teamName =
          json['team_name'].toString();
    } else if (json['team'] is Map) {
      teamName =
          json['team']['team_name']
                  ?.toString() ??
              '';
    } else if (json['project'] is Map) {
      final project =
          json['project'];

      if (project['team'] is Map) {
        teamName =
            project['team']['team_name']
                    ?.toString() ??
                '';
      }
    }

    //=========================================
    // Creator
    //=========================================

    String assignedByName =
        json['assigned_by_name']
                ?.toString() ??
            '';

    if (assignedByName.isEmpty &&
        json['creator'] is Map) {
      assignedByName =
          json['creator']['name']
                  ?.toString() ??
              '';
    }

    //=========================================
    // Assigned User
    //=========================================

    String assignedToName =
        json['assigned_to_name']
                ?.toString() ??
            '';

    if (assignedToName.isEmpty &&
        json['assignedUser'] is Map) {
      assignedToName =
          json['assignedUser']['name']
                  ?.toString() ??
              '';
    }

    //=========================================
    // Steps
    //=========================================

    final dynamic stepsJson =
        json['steps'];

    final List<TaskStep> steps =
        stepsJson is List
            ? stepsJson
                .whereType<Map>()
                .map(
                  (step) =>
                      TaskStep.fromJson(
                    Map<String, dynamic>.from(
                      step,
                    ),
                  ),
                )
                .toList()
            : [];

    //=========================================
    // Task
    //=========================================

    return TaskDetails(
      id: _parseInt(json['id']),

      name: json['title']?.toString() ??
          json['name']?.toString() ??
          '',

      deadline:
          json['deadline']?.toString() ?? '',

      teamName: teamName,

      assignedByName:
          assignedByName,

      assignedToName:
          assignedToName,

      steps: steps,
    );
  }

  bool get allStepsChecked {
    if (steps.isEmpty) {
      return false;
    }

    return steps.every(
      (step) => step.isChecked,
    );
  }

  int get checkedStepsCount =>
      steps
          .where(
            (step) => step.isChecked,
          )
          .length;

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }
}