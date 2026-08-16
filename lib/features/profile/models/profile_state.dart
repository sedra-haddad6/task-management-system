class ProfileStats {
  final int completedTasks;
  final int inProgressTasks;
  final int pendingTasks;

  final int currentScore;
  final int lostScore;

  const ProfileStats({
    required this.completedTasks,
    required this.inProgressTasks,
    required this.pendingTasks,
    required this.currentScore,
    required this.lostScore,
  });

  factory ProfileStats.fromJson(Map<String, dynamic> json) {
    return ProfileStats(
      completedTasks: _toInt(json['completed_tasks']),
      inProgressTasks: _toInt(json['in_progress_tasks']),
      pendingTasks: _toInt(json['pending_tasks']),
      currentScore: _toInt(json['current_score']),
      lostScore: _toInt(json['lost_score']),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;

    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.toInt();
    }

    return int.tryParse(value.toString()) ?? 0;
  }
}