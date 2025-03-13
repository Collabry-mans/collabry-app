import 'package:collabry/features/authentication/model/sign_up_model.dart';

class UserState {}

//* Register States
class RegisterLoadingState extends UserState {}

class RegisterLoadedState extends UserState {
  final SignUpModel signUp;
  RegisterLoadedState({required this.signUp});
}

class RegisterFailedState extends UserState {
  final String errMsg;
  RegisterFailedState({required this.errMsg});
}

//* Login States
class LoginLoadingState extends UserState {}

class LoginLoadedState extends UserState {}

class LoginFailedState extends UserState {}
