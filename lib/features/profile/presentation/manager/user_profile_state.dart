part of 'user_profile_cubit.dart';

sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoadingState extends UserProfileInitial {}

final class UserProfileLoadedState extends UserProfileInitial {
  final UserProfile user;

  UserProfileLoadedState({required this.user});
}

final class UserProfileFailedState extends UserProfileInitial {
  final ApiErrorModel errModel;

  UserProfileFailedState({required this.errModel});
}

final class UserProfileEditLoadedState extends UserProfileInitial {
  final UserProfile user;

  UserProfileEditLoadedState({required this.user});
}

final class UserProfileEditLoadingState extends UserProfileInitial {}

final class UserProfileEditFailedState extends UserProfileInitial {
  final ApiErrorModel errModel;

  UserProfileEditFailedState({required this.errModel});
}

final class UserProfileAvatarLoadedState extends UserProfileInitial {}

final class UserProfileAvatarLoadingState extends UserProfileInitial {}

final class UserProfileAvatarFailedState extends UserProfileInitial {
  final ApiErrorModel errModel;

  UserProfileAvatarFailedState({required this.errModel});
}
