import 'package:collabry/features/authentication/presentation/manager/auth_cubit.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/custom_button.dart';
import 'package:collabry/features/authentication/presentation/widgets/otp_verification_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationBottomSection extends StatefulWidget {
  const VerificationBottomSection({
    super.key,
    required this.onTap,
    required this.formKey,
    required this.otpControllers,
    required this.email,
  });

  final VoidCallback onTap;
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> otpControllers;
  final String email;

  @override
  State<VerificationBottomSection> createState() =>
      _VerificationBottomSectionState();
}

class _VerificationBottomSectionState extends State<VerificationBottomSection> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: widget.formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => OTPVerificationComponent(
                controller: widget.otpControllers[index],
              ),
            ),
          ),
        ),
        CustomButton(
          onTap: widget.onTap,
          text: AppStrings.verify,
          textStyle: AppTextStyles.belanosimaSize24W600Purple
              .copyWith(color: AppColors.white),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.didntReceiveAnyCode,
                style: AppTextStyles.belanosimaSize14.copyWith(fontSize: 11),
              ),
              TextSpan(
                text: '${AppStrings.resendAgain}\n',
                style: AppTextStyles.belanosimaSize24W600Purple
                    .copyWith(fontSize: 11),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => authCubit.sendOtpTo(email: widget.email),
              ),
              TextSpan(
                text: '${AppStrings.requestNewCodeIn} 00:30s',
                style: AppTextStyles.belanosimaSize14.copyWith(fontSize: 11),
              ),
            ],
          ),
        )
      ],
    );
  }
}
