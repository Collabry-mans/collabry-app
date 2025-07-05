import 'package:collabry/features/authentication/presentation/manager/auth_cubit.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/custom_button.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:collabry/features/authentication/presentation/widgets/customized_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

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
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
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
                      Assets.imagesSendVerification,
                      height: MediaQuery.sizeOf(context).height / 4.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.resetPass,
                    style:
                        AppTextStyles.belanosimaSize16.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 40),
                  CustomTxtField(
                    txtController:
                        context.read<AuthCubit>().resetpassNewPassController,
                    text: AppStrings.newPass,
                    icon: Icons.lock_outline_rounded,
                    color: AppColors.lightGray,
                    isPass: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTxtField(
                    txtController: context
                        .read<AuthCubit>()
                        .resetpassConfirmPassController,
                    text: AppStrings.confirmPassword,
                    icon: Icons.lock_outline_rounded,
                    color: AppColors.lightGray,
                    isPass: true,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.mainPageScreen, (route) => false);
                    },
                    text: AppStrings.resetPass,
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
