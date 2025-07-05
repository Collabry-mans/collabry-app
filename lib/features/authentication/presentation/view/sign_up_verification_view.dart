import 'package:collabry/features/authentication/presentation/manager/auth_cubit.dart';
import 'package:collabry/features/authentication/presentation/manager/auth_states.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
import 'package:collabry/features/authentication/presentation/widgets/verification_bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpVerificationView extends StatelessWidget {
  const SignUpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> otpFormKey = GlobalKey();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyOTPSuccessedState) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainPageScreen, (route) => false);
          } else if (state is VerifyOTPFailedState) {
            FlushBarUtils.flushBarError(state.errModel.message, context);
          }
        },
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();
          return Column(
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
                      const SizedBox(height: 80),
                      Center(
                        child: Image.asset(
                          Assets.imagesForgetPass,
                          height: MediaQuery.sizeOf(context).height / 4.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppStrings.verification,
                        style: AppTextStyles.belanosimaSize16Purple
                            .copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppStrings.verificationMsg,
                              style: AppTextStyles.belanosimaSize14
                                  .copyWith(fontSize: 11),
                            ),
                            TextSpan(
                              text: authCubit.registerEmailController.text,
                              style: AppTextStyles.belanosimaSize24W600Purple
                                  .copyWith(fontSize: 14),
                            ),
                            TextSpan(
                              text: AppStrings.forVerification,
                              style: AppTextStyles.belanosimaSize14
                                  .copyWith(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 4,
                        child: state is VerifyOTPLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : VerificationBottomSection(
                                onTap: () {
                                  if (otpFormKey.currentState!.validate()) {
                                    final String otpCode = authCubit
                                        .otpControllers
                                        .map((digit) => digit.text)
                                        .join();
                                    authCubit.verifyOTP(otpCode);
                                  }
                                },
                                formKey: otpFormKey,
                              ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
