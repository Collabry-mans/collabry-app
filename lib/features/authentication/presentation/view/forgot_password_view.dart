import 'package:collabry/core/cubit/auth_cubit.dart';
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

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.selectedColor,
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
                    style: AppTextStyles.belanosimaSize16Purple
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppStrings.dontWorryEnterTheEmail,
                    style: AppTextStyles.belanosimaSize14Grey
                        .copyWith(fontSize: 11),
                  ),
                  const SizedBox(height: 20),
                  CustomTxtField(
                    txtController:
                        context.read<AuthCubit>().forgotpassEmailController,
                    text: AppStrings.email,
                    icon: Icons.email_outlined,
                    color: AppColors.txtColor,
                  ),
                  const SizedBox(height: 70),
                  CustomButton(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, forgotPasswordVerificationScreen),
                    text: AppStrings.submit,
                    textStyle: AppTextStyles.belanosimaSize24W600Purple
                        .copyWith(color: AppColors.whiteColor),
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
