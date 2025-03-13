import 'package:collabry/core/cubit/user_states.dart';
import 'package:collabry/features/authentication/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.authRepo) : super(UserState());

  final AuthRepository authRepo;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

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

  void signUp() async {
    emit(RegisterLoadingState());
    try {
      final response = await authRepo.signUp(registerNameController.text,
          registerEmailController.text, registerPassController.text);
      emit(RegisterLoadedState(signUp: response));
    } on Exception catch (e) {
      emit(RegisterFailedState(errMsg: e.toString()));
    }
  }

  void signUpEmailVerification() async {
    emit(RegisterLoadingState());
    try {
      await authRepo.signupVerificationEmail(registerEmailController.text);
    } on Exception catch (e) {
      emit(RegisterFailedState(errMsg: e.toString()));
    }
  }
}
