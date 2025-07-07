import 'package:collabry/features/authentication/presentation/manager/auth_states.dart';
import 'package:collabry/core/di/di.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final BaseAuthRepository authRepo;

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    emit(RegisterLoadingState());
    final result = await authRepo.signUp(name, email.trim(), password);
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

  Future<void> logIn(String email, String password) async {
    emit(LoginLoadingState());
    final result = await authRepo.logIn(email.trim(), password);
    result.when(
      onSuccess: (user) {
        saveUserTokens(user.accessToken, user.refreshToken);
        emit(LoginLoadedState(logIn: user));
      },
      onFailure: (error) {
        emit(LoginFailedState(errModel: error));
      },
    );
  }

  Future<void> sendOtpTo({required String email}) async {
    final result = await authRepo.sendOtp(email.trim());
    result.when(
      onSuccess: (_) {},
      onFailure: (error) {
        emit(VerifyOTPFailedState(errModel: error));
      },
    );
  }

  Future<void> verifyOtpFor(String otpCode,
      {required String email, required String otp}) async {
    emit(VerifyOTPLoadingState());
    final result = await authRepo.verifyOtp(email.trim(), otp);
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
