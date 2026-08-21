class TaskStep {
  final int id;
  final String description;
  bool isChecked;

  TaskStep({
    required this.id,
    required this.description,
    this.isChecked = false,
  });

  factory TaskStep.fromJson(
    Map<String, dynamic> json,
  ) {
    return TaskStep(
      id: _parseInt(json['id']),

      description:
          json['description']?.toString() ??
              '',

      isChecked:
          json['is_checked'] == true ||
          json['completed'] == true,
    );
  }

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