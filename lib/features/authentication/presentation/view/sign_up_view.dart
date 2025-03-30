import 'package:collabry/core/cubit/auth/auth_cubit.dart';
import 'package:collabry/core/cubit/auth/auth_states.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
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
    final GlobalKey<FormState> registerFormKey = GlobalKey();
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
                      FlushBarUtils.flushBarMsg(
                          'A verification code will be sent to u . Check ur email',
                          context);
                      Navigator.pushNamed(
                          context, Routes.signUpVerificationScreen,
                          arguments: context.read<AuthCubit>());
                    } else if (state is RegisterFailedState) {
                      FlushBarUtils.flushBarError(state.errMsg, context);
                    }
                  },
                  builder: (context, state) => Form(
                    key: registerFormKey,
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
                                  if (registerFormKey.currentState
                                          ?.validate() ??
                                      false) {
                                    context.read<AuthCubit>().signUp();
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
