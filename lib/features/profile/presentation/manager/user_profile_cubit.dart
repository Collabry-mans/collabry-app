import 'package:collabry/core/errors/exception_handling.dart';
import 'package:collabry/features/profile/data/model/user_profile_model.dart';
import 'package:collabry/features/profile/data/repository/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepositoryBase userRepo;
  UserProfile? user;
  UserProfileCubit(this.userRepo) : super(UserProfileInitial());

  Future<void> getUserProfile() async {
    emit(UserProfileLoadingState());
    try {
      user = await userRepo.getUserProfile();
      emit(UserProfileLoadedState());
    } on ServerException catch (e) {
      emit(UserProfileFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }

  Future<void> updateUserProfile(
      {required String name,
      required String bio,
      required String linkedIn,
      required List<String> expertise,
      required List<String> languages}) async {
    try {
      emit(UserProfileEditLoadingState());
      await userRepo.updateUserProfile(
          name: name,
          bio: bio,
          linkedIn: linkedIn,
          expertise: expertise,
          languages: languages);

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
      emit(UserProfileEditLoadedState());
    } on ServerException catch (e) {
      emit(
          UserProfileEditFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }

  Future<void> updateUserProfileAvatar({required String avatar}) async {
    try {
      await userRepo.updateUserProfileImage(avatar);
      emit(UserProfileAvatarLoadedState());
    } on ServerException catch (e) {
      emit(UserProfileAvatarFailedState(
          errMsg: e.errModel.getFormattedMessage()));
    }
  }
}
