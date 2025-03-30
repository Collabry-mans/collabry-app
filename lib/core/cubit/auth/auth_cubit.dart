import 'package:collabry/core/cubit/auth/auth_states.dart';
import 'package:collabry/core/errors/exception_handling.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final BaseAuthRepository authRepo;
  //* login txt controllers
  TextEditingController logInEmailController = TextEditingController();
  TextEditingController logInPassController = TextEditingController();

  //* register txt controllers
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerPassController = TextEditingController();
  TextEditingController registerConfirmPassController = TextEditingController();

//* Signup verification OTP
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  //* ForgotPassword controllers
  TextEditingController forgotpassEmailController = TextEditingController();

  //* ResetPassword controllers
  TextEditingController resetpassNewPassController = TextEditingController();
  TextEditingController resetpassConfirmPassController =
      TextEditingController();

  Future<void> signUp() async {
    emit(RegisterLoadingState());
    try {
      final user = await authRepo.signUp(
        registerNameController.text,
        registerEmailController.text.trim(),
        registerPassController.text,
      );
      saveUserTokens(user.accessToken, user.refreshToken);
      emit(RegisterLoadedState(signUp: user));
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
        logInEmailController.text.trim(),
        logInPassController.text,
      );
      saveUserTokens(user.accessToken, user.refreshToken);
      emit(LoginLoadedState(logIn: user));
    } on DioException catch (e) {
      handleDioExceptions(e);
    } on ServerException catch (e) {
      emit(LoginFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }

  Future<void> sendOTP() async {
    try {
      await authRepo.sendOtp(registerEmailController.text.trim());
    } on DioException catch (e) {
      handleDioExceptions(e);
    } on ServerException catch (e) {
      emit(VerifyOTPFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      emit(VerifyOTPLoadingState());
      await authRepo.verifyOtp(registerEmailController.text.trim(), otp);

      emit(VerifyOTPSuccessedState(otpCode: otp));
    } on DioException catch (e) {
      handleDioExceptions(e);
    } on ServerException catch (e) {
      emit(VerifyOTPFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }
}

Future<void> saveUserTokens(String accessToken, String refreshToken) async {
  await secureStorage.write(key: accessTokenKey, value: accessToken);
  await secureStorage.write(key: refreshTokenKey, value: refreshToken);
}
