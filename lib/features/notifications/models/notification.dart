class AppNotification {
  final int id;
  final String title;
  final String message;
  final String? createdAt;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    this.createdAt,
    this.isRead = false,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      createdAt: json['created_at']?.toString(),
      isRead: json['is_read'] ?? false,
    );
  }
}