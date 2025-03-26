import 'package:another_flushbar/flushbar.dart';
import 'package:collabry/core/cubit/auth_cubit.dart';
import 'package:collabry/core/cubit/auth_states.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/custom_button.dart';
import 'package:collabry/features/authentication/presentation/widgets/auth_bottom_section.dart';
import 'package:collabry/features/authentication/presentation/widgets/customized_app_bar.dart';
import 'package:collabry/features/authentication/presentation/widgets/signup_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.read<AuthCubit>().registerFormKey;
    return Scaffold(
      backgroundColor: AppColors.selectedColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Assets.imagesUpperAuth,
                height: MediaQuery.sizeOf(context).height / 6.5,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                decoration: const BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is RegisterLoadedState) {
                      Flushbar(
                        margin: const EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(8),
                        message:
                            'A verification email will be sent. Check your email',
                        flushbarStyle: FlushbarStyle.FLOATING,
                        icon: const Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: AppColors.primaryColor,
                        ),
                        duration: const Duration(seconds: 3),
                        leftBarIndicatorColor: AppColors.primaryColor,
                      ).show(context);
                      Navigator.pushNamedAndRemoveUntil(context,
                          Routes.signUpVerificationScreen, (route) => false);
                    } else if (state is RegisterFailedState) {
                      Flushbar(
                        margin: const EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(8),
                        message: state.errMsg,
                        flushbarStyle: FlushbarStyle.FLOATING,
                        icon: const Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: Colors.red,
                        ),
                        duration: const Duration(seconds: 3),
                        leftBarIndicatorColor: AppColors.primaryColor,
                      ).show(context);
                    }
                  },
                  builder: (context, state) => Form(
                    key: context.read<AuthCubit>().registerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomizedAppBar(),
                        Text(
                          AppStrings.getStarted,
                          style: AppTextStyles.barlowSize42BoldPurple
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        const SignupTextFields(),
                        const SizedBox(height: 20),
                        state is RegisterLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                onTap: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    context.read<AuthCubit>().signUp();
                                    context.read<AuthCubit>().sendOTP();
                                  }
                                },
                                text: AppStrings.signUp,
                                textStyle: AppTextStyles
                                    .belanosimaSize24W600Purple
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                        const Expanded(
                          child: AuthBottomSection(
                            title: AppStrings.orSignUpWith,
                            text: AppStrings.alreadyHaveAnAccount,
                            textButtonTxt: AppStrings.logIn,
                            screen: Routes.logInScreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
