class User {
  int? id;
  String? roleId;
  String? role;
  String? firstName;
  dynamic lastName;
  String? profileImageUrl;

  User({
    this.id,
    this.roleId,
    this.role,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    roleId: json['role_id'] as String?,
    role: json['role'] as String?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as dynamic,
    profileImageUrl: json['profile_image_url'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'role_id': roleId,
    'role': role,
    'first_name': firstName,
    'last_name': lastName,
    'profile_image_url': profileImageUrl,
  };
}
