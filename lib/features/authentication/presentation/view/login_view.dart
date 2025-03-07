import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:flutter/material.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.imagesUpperLogin,
            height: MediaQuery.sizeOf(context).height / 7,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              AppStrings.hello,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 52,
                fontFamily: 'Barlow_header',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              AppStrings.welcomeBack,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 12,
                fontFamily: 'Belanosima_text',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: const BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.logIn,
                        style: TextStyle(
                          color: AppColors.selectedColor,
                          fontSize: 42,
                          fontFamily: 'Barlow_header',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const CustomTxtField(
                        text: AppStrings.email,
                        icon: Icons.mail_outlined,
                        textColor: AppColors.txtColor,
                        iconColor: AppColors.txtColor,
                      ),
                      const SizedBox(height: 20),
                      const CustomTxtField(
                        text: AppStrings.pass,
                        icon: Icons.lock_outlined,
                        textColor: AppColors.txtColor,
                        iconColor: AppColors.txtColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                side: const BorderSide(
                                  color: AppColors.txtColor,
                                  width: 2,
                                ),
                                value: isSelected,
                                onChanged: (selectedStatus) => setState(
                                    () => isSelected = selectedStatus ?? false),
                              ),
                              const Text(
                                AppStrings.rememberMe,
                                style: TextStyle(
                                  color: AppColors.txtColor,
                                  fontFamily: 'Belanosima_text',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              AppStrings.forgotPassword,
                              style: TextStyle(
                                color: AppColors.selectedColor,
                                fontFamily: 'Belanosima_text',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: MediaQuery.sizeOf(context).height * 0.65,
                  child: Image.asset(Assets.imagesLogInContainer,
                      height: MediaQuery.sizeOf(context).height / 5),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
