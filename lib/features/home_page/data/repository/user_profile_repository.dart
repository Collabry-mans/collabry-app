import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/home_page/data/model/user_profile_model.dart';
import 'package:collabry/main.dart';

abstract class UserProfileRepositoryBase {
  Future<UserProfile> getUserProfile();
  Future<void> updateUserProfile(
      {required String name,
      required String bio,
      required String linkedIn,
      required List<String> expertise,
      required List<String> languages});
  Future<void> updateUserProfileImage(String profileImage);
  Future<void> saveUserProfile(UserProfile userProfile);
}

class UserProfileRepo extends UserProfileRepositoryBase {
  final DioConsumer dio;

  UserProfileRepo({required this.dio});
  @override
  Future<UserProfile> getUserProfile() async {
    final Map<String, dynamic> response = await dio.get(EndPoints.userProfile);
    final userProfile = UserProfile.fromJson(response);
    await saveUserProfile(userProfile);
    return userProfile;
  }

  @override
  Future<void> saveUserProfile(UserProfile userProfile) async {
    await userBox!.put(kUserName, userProfile.name);
    await userBox!.put(kUserEmail, userProfile.email);
  }

  @override
  Future<void> updateUserProfileImage(String profileImage) async {
    await dio.patch(EndPoints.userProfileAvatar,
        data: {ApiKeys.avatar: profileImage});
  }

  @override
  Future<void> updateUserProfile(
      {required String name,
      required String bio,
      required String linkedIn,
      required List<String> expertise,
      required List<String> languages}) async {
    await dio.put(EndPoints.userProfile, data: {
      ApiKeys.name: name,
      ApiKeys.bio: bio,
      ApiKeys.linkedin: linkedIn,
      ApiKeys.expertise: expertise,
      ApiKeys.languages: languages,
    });
  }
}
