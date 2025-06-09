import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/api/networking/api_error_handler.dart';
import 'package:collabry/core/api/networking/api_result.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/profile/data/model/user_profile_model.dart';
import 'package:collabry/main.dart';
import 'package:dio/dio.dart';

abstract class UserProfileRepositoryBase {
  Future<ApiResult<UserProfile>> getUserProfile();
  Future<ApiResult<void>> updateUserProfile({
    required String name,
    required String bio,
    required String linkedIn,
    required List<String> expertise,
    required List<String> languages,
  });
  Future<ApiResult<void>> updateUserProfileImage(String profileImage);
  Future<void> saveUserProfile({required String name, email, image});
}

class UserProfileRepo implements UserProfileRepositoryBase {
  final DioConsumer dio;

  UserProfileRepo({required this.dio});

  @override
  Future<ApiResult<UserProfile>> getUserProfile() async {
    try {
      final Map<String, dynamic> response =
          await dio.get(EndPoints.userProfile);
      final userProfile = UserProfile.fromJson(response);
      await saveUserProfile(
        name: userProfile.name,
        email: userProfile.email,
        image: userProfile.profile.profileImage,
      );
      return ApiResult.success(userProfile);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<void> saveUserProfile({String? name, email, image}) async {
    await userBox!.put(kUserName, name ?? userBox!.get(kUserName));
    await userBox!.put(kUserEmail, email ?? userBox!.get(kUserEmail));
    await userBox!.put(kUserAvatar, image ?? userBox!.get(kUserAvatar));
  }

  @override
  Future<ApiResult<void>> updateUserProfile({
    required String name,
    required String bio,
    required String linkedIn,
    required List<String> expertise,
    required List<String> languages,
  }) async {
    try {
      await dio.put(EndPoints.userProfile, data: {
        ApiKeys.name: name,
        ApiKeys.bio: bio,
        ApiKeys.linkedin: linkedIn,
        ApiKeys.expertise: expertise,
        ApiKeys.languages: languages,
      });
      saveUserProfile(name: name);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> updateUserProfileImage(String profileImage) async {
    try {
      await dio.patch(
        EndPoints.userProfileAvatar,
        data: {
          ApiKeys.avatar: await MultipartFile.fromFile(
            profileImage,
            filename: profileImage.split('/').last,
          ),
        },
        isFormData: true,
      );
      await userBox!.put(kUserAvatar, profileImage);

      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
