class ProfileStats {
  final int completedTasks;
  final int inProgressTasks;
  final int pendingTasks;

  final int currentScore;
  final int lostScore;

  ProfileStats({
    required this.completedTasks,
    required this.inProgressTasks,
    required this.pendingTasks,
    required this.currentScore,
    required this.lostScore,
  });

  factory ProfileStats.fromJson(Map<String, dynamic> json) {
    return ProfileStats(
      completedTasks: json['completed_tasks'] ?? 0,
      inProgressTasks: json['in_progress_tasks'] ?? 0,
      pendingTasks: json['pending_tasks'] ?? 0,
      currentScore: json['current_score'] ?? 0,
      lostScore: json['lost_score'] ?? 0,
    );
  }
}