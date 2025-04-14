import 'package:collabry/core/errors/exception_handling.dart';
import 'package:collabry/features/home_page/data/repository/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepositoryBase userRepo;
  UserProfileCubit(this.userRepo) : super(UserProfileInitial());

  Future<void> getUserProfile() async {
    emit(UserProfileLoadingState());
    try {
      await userRepo.getUserProfile();
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
      await userRepo.updateUserProfile(
          name: name,
          bio: bio,
          linkedIn: linkedIn,
          expertise: expertise,
          languages: languages);
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
