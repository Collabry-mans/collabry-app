import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/custom_button.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:collabry/features/authentication/presentation/widgets/customized_app_bar.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late TextEditingController forgetPassController;
  @override
  void initState() {
    forgetPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    forgetPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
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
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              decoration: const BoxDecoration(
                color: AppColors.surfaceBackground,
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
                  Center(
                    child: Image.asset(
                      Assets.imagesForgetPass,
                      height: MediaQuery.sizeOf(context).height / 4.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppStrings.forgotPassword,
                    style:
                        AppTextStyles.belanosimaSize16.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppStrings.dontWorryEnterTheEmail,
                    style:
                        AppTextStyles.belanosimaSize14.copyWith(fontSize: 11),
                  ),
                  const SizedBox(height: 20),
                  CustomTxtField(
                    txtController: forgetPassController,
                    text: AppStrings.email,
                    icon: Icons.email_outlined,
                    color: AppColors.lightGray,
                  ),
                  const SizedBox(height: 70),
                  CustomButton(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, Routes.forgotPasswordVerificationScreen),
                    text: AppStrings.submit,
                    textStyle: AppTextStyles.belanosimaSize24W600Purple
                        .copyWith(color: AppColors.white),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
