import 'package:collabry/core/cubit/auth_states.dart';
import 'package:collabry/core/errors/exception_handling.dart';
import 'package:collabry/features/authentication/repository/auth_repository.dart';
import 'package:dio/dio.dart';
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
      final response = await authRepo.signUp(registerNameController.text,
          registerEmailController.text.trim(), registerPassController.text);
      emit(RegisterLoadedState(signUp: response));
    } on DioException catch (e) {
      handleDioExceptions(e);
    } on ServerException catch (e) {
      emit(RegisterFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }

  Future<void> logIn() async {
    emit(LoginLoadingState());
    try {
      final user = await authRepo.logIn(
          logInEmailController.text.trim(), logInPassController.text);
      emit(LoginLoadedState(logIn: user));
    } on DioException catch (e) {
      handleDioExceptions(e);
    } on ServerException catch (e) {
      emit(LoginFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }
}
