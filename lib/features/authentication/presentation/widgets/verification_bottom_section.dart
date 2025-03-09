import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/custom_button.dart';
import 'package:collabry/features/authentication/presentation/widgets/otp_verification_component.dart';
import 'package:flutter/material.dart';

class VerificationBottomSection extends StatelessWidget {
  const VerificationBottomSection({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (_) => const OTPVerificationComponent()),
        ),
        CustomButton(
          onTap: onTap,
          text: AppStrings.verify,
          textStyle: AppTextStyles.belanosimaSize24W600Purple
              .copyWith(color: AppColors.whiteColor),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: AppStrings.didntReceiveAnyCode,
                style:
                    AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 11),
              ),
              TextSpan(
                text: '${AppStrings.resendAgain}\n',
                style: AppTextStyles.belanosimaSize24W600Purple
                    .copyWith(fontSize: 11),
              ),
              TextSpan(
                text: '${AppStrings.requestNewCodeIn} 00:30s',
                style:
                    AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 11),
              ),
            ],
          ),
        )
      ],
    );
  }
}
