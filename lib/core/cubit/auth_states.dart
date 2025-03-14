import 'package:collabry/features/authentication/model/sign_up_model.dart';

class AuthState {}

//* Register States
class RegisterLoadingState extends AuthState {}

class RegisterLoadedState extends AuthState {
  final SignUpModel signUp;
  RegisterLoadedState({required this.signUp});
}

class RegisterFailedState extends AuthState {
  final String errMsg;
  RegisterFailedState({required this.errMsg});
}

//* Login States
class LoginLoadingState extends AuthState {}

class LoginLoadedState extends AuthState {}

class LoginFailedState extends AuthState {
  final String errMsg;
  LoginFailedState({required this.errMsg});
}
