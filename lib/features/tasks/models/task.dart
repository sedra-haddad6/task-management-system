import 'dart:convert';

enum TaskStatus {
  pending,
  inProgress,
  done,
  cancelled,
}

TaskStatus taskStatusFromString(
  String? value,
) {
  switch (value) {
    case 'in_progress':
      return TaskStatus.inProgress;

    case 'completed':
    case 'done':
      return TaskStatus.done;

    case 'cancelled':
      return TaskStatus.cancelled;

    case 'pending':
    default:
      return TaskStatus.pending;
  }
}

class Task {
  final int id;

  // UI uses "name", while API uses "title".
  final String name;

  final String deadline;

  // May not exist directly in the task response.
  final String teamName;

  final TaskStatus status;

  final int? projectId;
  final int? assignedTo;
  final int? createdBy;

  Task({
    required this.id,
    required this.name,
    required this.deadline,
    required this.teamName,
    required this.status,
    this.projectId,
    this.assignedTo,
    this.createdBy,
  });

  factory Task.fromRawJson(String str) =>
      Task.fromJson(
        json.decode(str),
      );

  String toRawJson() =>
      json.encode(toJson());

  factory Task.fromJson(
    Map<String, dynamic> json,
  ) {
    //=========================================
    // Team
    //=========================================

    String teamName = '';

    if (json['team_name'] != null) {
      teamName =
          json['team_name'].toString();
    }
     else if (json['team'] is Map) {
      teamName =
          json['team']['team_name']
                  ?.toString() ??
              '';
    }

    //=========================================
    // Title
    //=========================================

    final String title =
        json['title']?.toString() ??
            json['name']?.toString() ??
            '';

    //=========================================
    // ID
    //=========================================

    final int id =
        _parseInt(json['id']);

    //=========================================
    // Deadline
    //=========================================

    final String deadline =
        json['deadline']?.toString() ?? '';

    //=========================================
    // IDs
    //=========================================

    final int? projectId =
        _parseNullableInt(
      json['project_id'],
    );

    final int? assignedTo =
        _parseNullableInt(
      json['assigned_to'],
    );

    final int? createdBy =
        _parseNullableInt(
      json['created_by'],
    );

    return Task(
      id: id,
      name: title,
      deadline: deadline,
      teamName: teamName,
      status: taskStatusFromString(
        json['status']?.toString(),
      ),
      projectId: projectId,
      assignedTo: assignedTo,
      createdBy: createdBy,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'deadline': deadline,
        'team_name': teamName,
        'status': _statusToString(status),
        'project_id': projectId,
        'assigned_to': assignedTo,
        'created_by': createdBy,
      };

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static int? _parseNullableInt(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return value;
    }

    return int.tryParse(
      value.toString(),
    );
  }

  static String _statusToString(
    TaskStatus status,
  ) {
    switch (status) {
      case TaskStatus.inProgress:
        return 'in_progress';

      case TaskStatus.done:
        return 'done';

      case TaskStatus.cancelled:
        return 'cancelled';

      case TaskStatus.pending:
        return 'pending';
    }
  }
}