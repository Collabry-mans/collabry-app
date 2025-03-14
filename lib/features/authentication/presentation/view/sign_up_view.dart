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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please verify ur email'))),
      builder: (context, state) => Scaffold(
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
                        Form(
                          key: formKey,
                          child: const SignupTextFields(),
                        ),
                        const SizedBox(height: 20),
                        (state is RegisterLoadingState)
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                onTap: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    if (state is RegisterLoadedState) {
                                      context.read<AuthCubit>().signUp();
                                      context
                                          .read<AuthCubit>()
                                          .signUpEmailVerification();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          signUpVerificationScreen,
                                          (route) => false);
                                    }
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
                            screen: logInScreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
