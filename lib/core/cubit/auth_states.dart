import 'package:collabry/features/authentication/model/log_in_model.dart';
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

class LoginLoadedState extends AuthState {
  final LogInModel logIn;
  LoginLoadedState({required this.logIn});
}

class LoginFailedState extends AuthState {
  final String errMsg;
  LoginFailedState({required this.errMsg});
}
