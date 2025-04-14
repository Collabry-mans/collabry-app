import 'package:collabry/core/api/end_points.dart';

class UserProfile {
  final String email;
  final String name;
  final Profile profile;

  UserProfile({required this.email, required this.name, required this.profile});
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        email: json[ApiKeys.email],
        name: json[ApiKeys.name],
        profile: Profile.fromJson(json[ApiKeys.profile]));
  }
}

class Profile {
  final String profileImage;
  final String bio;
  final String? linkedIn;
  final List<dynamic> expertise;
  final List<dynamic> languages;

  Profile(
      {required this.profileImage,
      required this.bio,
      required this.linkedIn,
      required this.expertise,
      required this.languages});
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        profileImage: json[ApiKeys.profileImageUrl],
        bio: json[ApiKeys.bio],
        linkedIn: json[ApiKeys.linkedin],
        expertise: json[ApiKeys.expertise],
        languages: json[ApiKeys.languages]);
  }
}
