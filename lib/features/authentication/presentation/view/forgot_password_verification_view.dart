import 'package:collabry/features/authentication/presentation/manager/auth_cubit.dart';
import 'package:collabry/features/authentication/presentation/manager/auth_states.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/customized_app_bar.dart';
import 'package:collabry/features/authentication/presentation/widgets/verification_bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordVerificationView extends StatelessWidget {
  const ForgotPasswordVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> forgetPassFormKey = GlobalKey();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
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
                            style: AppTextStyles.belanosimaSize16Purple
                                .copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.verificationMsg,
                                  style: AppTextStyles.belanosimaSize14Grey
                                      .copyWith(fontSize: 11),
                                ),
                                TextSpan(
                                  text: ' contact.uiRandom@gmail.com ',
                                  style: AppTextStyles
                                      .belanosimaSize24W600Purple
                                      .copyWith(fontSize: 14),
                                ),
                                TextSpan(
                                  text: AppStrings.forVerification,
                                  style: AppTextStyles.belanosimaSize14Grey
                                      .copyWith(fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height / 4,
                            child: VerificationBottomSection(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, Routes.resetPasswordScreen),
                              formKey: forgetPassFormKey,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
