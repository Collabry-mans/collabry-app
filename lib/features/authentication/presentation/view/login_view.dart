import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/custom_button.dart';
import 'package:collabry/features/authentication/presentation/widgets/auth_bottom_section.dart';
import 'package:collabry/features/authentication/presentation/widgets/login_text_fields.dart';
import 'package:flutter/material.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Assets.imagesUpperAuth,
                height: MediaQuery.sizeOf(context).height / 7,
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
                padding: EdgeInsets.only(left: 18, bottom: 60),
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
                          const Text(
                            AppStrings.logIn,
                            style: AppTextStyles.barlowSize42BoldPurple,
                          ),
                          const SizedBox(height: 20),
                          const LoginTextFields(),
                          const SizedBox(height: 30),
                          CustomButton(
                            onTap: () {},
                            text: AppStrings.logIn,
                            textStyle: AppTextStyles.belanosimaSize24W600Purple
                                .copyWith(color: AppColors.whiteColor),
                          ),
                          const SizedBox(height: 50),
                          const Expanded(child: AuthBottomSection())
                        ],
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
