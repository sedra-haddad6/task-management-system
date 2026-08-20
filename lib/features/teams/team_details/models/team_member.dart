class TeamMember {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? profileImage;
  final String status;
  final int pointsEarned;

  TeamMember({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImage,
    required this.status,
    required this.pointsEarned,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    final pivot = json['pivot'];

    return TeamMember(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profile_image']?.toString(),
      status: pivot is Map
          ? (pivot['status'] ?? 'active')
          : 'active',
      pointsEarned: pivot is Map
          ? (pivot['points_earned'] ?? 0)
          : 0,
    );
  }
}