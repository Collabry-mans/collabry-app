import 'package:collabry/core/cubit/auth_states.dart';
import 'package:collabry/features/authentication/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthState());

  final BaseAuthRepository authRepo;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //* login txt controllers
  TextEditingController logInEmailController = TextEditingController();
  TextEditingController logInPassController = TextEditingController();

  //* register txt controllers
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerPassController = TextEditingController();
  TextEditingController registerConfirmPassController = TextEditingController();

  //* ForgotPassword controllers
  TextEditingController forgotpassEmailController = TextEditingController();

  //* ResetPassword controllers
  TextEditingController resetpassNewPassController = TextEditingController();
  TextEditingController resetpassConfirmPassController =
      TextEditingController();

  Future<void> signUp() async {
    emit(RegisterLoadingState());
    try {
      final response = await authRepo.signUp(
          registerNameController.text.trim(),
          registerEmailController.text.trim(),
          registerPassController.text.trim());
      emit(RegisterLoadedState(signUp: response));
    } on Exception catch (e) {
      emit(RegisterFailedState(errMsg: e.toString()));
    }
  }

  Future<void> signUpEmailVerification() async {
    emit(RegisterLoadingState());
    try {
      await authRepo
          .signupVerificationEmail(registerEmailController.text.trim());
    } on Exception catch (e) {
      emit(RegisterFailedState(errMsg: e.toString()));
    }
  }

  Future<void> logIn() async {
    emit(LoginLoadingState());
    try {
      await authRepo.logIn(
          logInEmailController.text.trim(), logInPassController.text.trim());
      emit(LoginLoadedState());
    } on Exception catch (e) {
      emit(LoginFailedState(errMsg: e.toString()));
    }
  }
}
