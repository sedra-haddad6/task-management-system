class TaskStep {
  String id;
  String description;
  bool isChecked;

  TaskStep({
    required this.id,
    required this.description,
    this.isChecked = false,
  });

  factory TaskStep.fromJson(Map<String, dynamic> json) => TaskStep(
    id: json["id"].toString(),
    description: json["description"],
    isChecked: json["is_checked"] ?? false,
  );
}