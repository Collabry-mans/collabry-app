import 'package:collabry/features/authentication/data/model/log_in_model.dart';
import 'package:collabry/features/authentication/data/model/sign_up_model.dart';
import 'package:collabry/core/api/networking/api_error_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

//* Register States
class RegisterLoadingState extends AuthState {}

class RegisterLoadedState extends AuthState {
  final SignUpModel signUp;
  RegisterLoadedState({required this.signUp});
}

class RegisterFailedState extends AuthState {
  final ApiErrorModel errModel;
  RegisterFailedState({required this.errModel});
}

//* Login States
class LoginLoadingState extends AuthState {}

class LoginLoadedState extends AuthState {
  final LogInModel logIn;
  LoginLoadedState({required this.logIn});
}

class LoginFailedState extends AuthState {
  final ApiErrorModel errModel;
  LoginFailedState({required this.errModel});
}

//* OTP
class VerifyOTPFailedState extends AuthState {
  final ApiErrorModel errModel;
  VerifyOTPFailedState({required this.errModel});
}

class VerifyOTPSuccessedState extends AuthState {
  final String otpCode;
  VerifyOTPSuccessedState({required this.otpCode});
}

class VerifyOTPLoadingState extends AuthState {}
