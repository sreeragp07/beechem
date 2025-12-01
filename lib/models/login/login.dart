import 'user.dart';

class Login {
  bool? status;
  String? accessToken;
  String? refreshToken;
  double? expiresInSec;
  User? user;

  Login({
    this.status,
    this.accessToken,
    this.refreshToken,
    this.expiresInSec,
    this.user,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    status: json['status'] as bool?,
    accessToken: json['access_token'] as String?,
    refreshToken: json['refresh_token'] as String?,
    expiresInSec: (json['expires_in_sec'] as num?)?.toDouble(),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'expires_in_sec': expiresInSec,
    'user': user?.toJson(),
  };
}
