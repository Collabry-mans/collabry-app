import 'package:collabry/features/authentication/presentation/manager/auth_cubit.dart';
import 'package:collabry/features/authentication/presentation/manager/auth_states.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/custom_button.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
import 'package:collabry/features/authentication/presentation/widgets/auth_bottom_section.dart';
import 'package:collabry/features/authentication/presentation/widgets/login_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  late TextEditingController emailController;
  late TextEditingController passController;
  @override
  initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> logInFormKey = GlobalKey();
    return Scaffold(
      backgroundColor: AppColors.primary,
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
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  AppStrings.hello,
                  style: AppTextStyles.barlowSize52BoldWhite,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18, bottom: 40),
                child: Text(
                  AppStrings.welcomeBack,
                  style: AppTextStyles.belanosimaSize12White,
                ),
              ),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceBackground,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      child: BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is LoginLoadedState) {
                            Navigator.pushReplacementNamed(
                                context, Routes.mainPageScreen);
                            FlushBarUtils.flushBarSuccess(
                                AppStrings.welcomeBack, context);
                          } else if (state is LoginFailedState) {
                            FlushBarUtils.flushBarError(
                                state.errModel.message, context);
                          }
                        },
                        builder: (context, state) {
                          return Form(
                            key: logInFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  AppStrings.logIn,
                                  style: AppTextStyles.barlowSize42BoldPurple,
                                ),
                                const SizedBox(height: 20),
                                LoginTextFields(
                                    emailController: emailController,
                                    passController: passController),
                                const SizedBox(height: 30),
                                state is LoginLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : CustomButton(
                                        onTap: () {
                                          if (logInFormKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            context.read<AuthCubit>().logIn(
                                                emailController.text,
                                                passController.text);
                                          }
                                        },
                                        text: AppStrings.logIn,
                                        textStyle: AppTextStyles
                                            .belanosimaSize24W600Purple
                                            .copyWith(color: AppColors.white),
                                      ),
                                const SizedBox(height: 50),
                                const Expanded(
                                  child: AuthBottomSection(
                                    title: AppStrings.orLoginWith,
                                    text: AppStrings.dontHaveAnAccount,
                                    textButtonTxt: AppStrings.signUp,
                                    screen: Routes.signUpScreen,
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: -MediaQuery.sizeOf(context).width / 3.5,
                      child: Image.asset(Assets.imagesLogInContainer,
                          height: MediaQuery.sizeOf(context).height / 5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
