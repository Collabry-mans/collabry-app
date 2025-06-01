import 'package:collabry/core/api/end_points.dart';

class User {
  String userId;
  String name;
  String role;
  String profileImageUrl;
  User(
      {required this.userId,
      required this.name,
      required this.profileImageUrl,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json[ApiKeys.id],
        name: json[ApiKeys.name],
        profileImageUrl: json[ApiKeys.profileImageUrl],
        role: json[ApiKeys.role]);
  }
}
