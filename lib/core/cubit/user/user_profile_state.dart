part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoadingState extends UserProfileInitial {}

final class UserProfileLoadedState extends UserProfileInitial {}

final class UserProfileFailedState extends UserProfileInitial {
  final String errMsg;

  UserProfileFailedState({required this.errMsg});
}

final class UserProfileEditLoadedState extends UserProfileInitial {}

final class UserProfileEditFailedState extends UserProfileInitial {
  final String errMsg;

  UserProfileEditFailedState({required this.errMsg});
}

final class UserProfileAvatarLoadedState extends UserProfileInitial {}

final class UserProfileAvatarFailedState extends UserProfileInitial {
  final String errMsg;

  UserProfileAvatarFailedState({required this.errMsg});
}
