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

  factory TeamMember.fromJson(
    Map<String, dynamic> json,
  ) {
    final dynamic pivot = json['pivot'];

    return TeamMember(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(
                json['id']?.toString() ?? '',
              ) ??
              0,

      name: json['name']?.toString() ?? '',

      email: json['email']?.toString() ?? '',

      role: json['role']?.toString() ?? '',

      profileImage: json['profile_image'] != null
          ? json['profile_image'].toString()
          : null,

      status: pivot is Map
          ? pivot['status']?.toString() ?? 'active'
          : 'active',

      pointsEarned: pivot is Map
          ? int.tryParse(
                pivot['points_earned']
                        ?.toString() ??
                    '',
              ) ??
              0
          : 0,
    );
  }
}