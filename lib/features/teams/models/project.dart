import 'dart:convert';

class Project {
  int id;
  String title;
  String status;

  Project({
    required this.id,
    required this.title,
    required this.status,
  });

  factory Project.fromRawJson(String str) => Project.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    title: json["title"],
    status: json["status"] ?? "pending",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
  };
}