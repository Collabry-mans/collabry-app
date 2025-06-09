import 'package:collabry/core/api/networking/api_error_model.dart';
import 'package:collabry/features/profile/data/model/user_profile_model.dart';
import 'package:collabry/features/profile/data/repository/user_profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepositoryBase userRepo;
  UserProfile? user;

  UserProfileCubit(this.userRepo) : super(UserProfileInitial());

  Future<void> getUserProfile() async {
    emit(UserProfileLoadingState());
    final result = await userRepo.getUserProfile();
    result.when(
      onSuccess: (userProfile) {
        user = userProfile;
        emit(UserProfileLoadedState(user: user!));
      },
      onFailure: (error) {
        emit(UserProfileFailedState(errModel: error));
      },
    );
  }

  Future<void> updateUserProfile({
    required String name,
    required String bio,
    required String linkedIn,
    required List<String> expertise,
    required List<String> languages,
  }) async {
    emit(UserProfileEditLoadingState());
    final result = await userRepo.updateUserProfile(
      name: name,
      bio: bio,
      linkedIn: linkedIn,
      expertise: expertise,
      languages: languages,
    );
    result.when(
      onSuccess: (_) {
        user = UserProfile(
          email: user!.email,
          name: name.isEmpty ? user!.name : name,
          profile: Profile(
            profileImage: user!.profile.profileImage,
            bio: bio.isEmpty ? user!.profile.bio : bio,
            linkedIn: linkedIn.isEmpty ? user!.profile.linkedIn : linkedIn,
            expertise: expertise.isEmpty ? user!.profile.expertise : expertise,
            languages: languages.isEmpty ? user!.profile.languages : languages,
          ),
        );
        emit(UserProfileEditLoadedState(user: user!));
      },
      onFailure: (error) {
        emit(UserProfileEditFailedState(errModel: error));
      },
    );
  }

  Future<void> updateUserProfileAvatar({required String avatar}) async {
    emit(UserProfileAvatarLoadingState());
    final result = await userRepo.updateUserProfileImage(avatar);
    result.when(
      onSuccess: (_) {
        emit(UserProfileAvatarLoadedState());
      },
      onFailure: (error) {
        emit(UserProfileAvatarFailedState(errModel: error));
      },
    );
  }
}
