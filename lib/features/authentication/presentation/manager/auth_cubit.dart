import 'package:collabry/features/authentication/presentation/manager/auth_states.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/data/repository/auth_repository.dart';
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
    final result = await authRepo.signUp(
      registerNameController.text,
      registerEmailController.text.trim(),
      registerPassController.text,
    );
    result.when(
      onSuccess: (user) {
        saveUserTokens(user.accessToken, user.refreshToken);
        emit(RegisterLoadedState(signUp: user));
      },
      onFailure: (error) {
        emit(RegisterFailedState(errModel: error));
      },
    );
  }

  Future<void> logIn() async {
    emit(LoginLoadingState());
    final result = await authRepo.logIn(
      logInEmailController.text.trim(),
      logInPassController.text,
    );
    result.when(
      onSuccess: (user) {
        saveUserTokens(user.accessToken, user.refreshToken);
        final userProfileCubit = getIt<UserProfileCubit>();
        userProfileCubit.getUserProfile();
        emit(LoginLoadedState(logIn: user));
      },
      onFailure: (error) {
        emit(LoginFailedState(errModel: error));
      },
    );
  }

  Future<void> sendOTP() async {
    final result = await authRepo.sendOtp(registerEmailController.text.trim());
    result.when(
      onSuccess: (_) {},
      onFailure: (error) {
        emit(VerifyOTPFailedState(errModel: error));
      },
    );
  }

  Future<void> verifyOTP(String otp) async {
    emit(VerifyOTPLoadingState());
    final result =
        await authRepo.verifyOtp(registerEmailController.text.trim(), otp);
    result.when(
      onSuccess: (_) {
        emit(VerifyOTPSuccessedState(otpCode: otp));
      },
      onFailure: (error) {
        emit(VerifyOTPFailedState(errModel: error));
      },
    );
  }
}

Future<void> saveUserTokens(String accessToken, String refreshToken) async {
  await secureStorage.write(key: accessTokenKey, value: accessToken);
  await secureStorage.write(key: refreshTokenKey, value: refreshToken);
}
