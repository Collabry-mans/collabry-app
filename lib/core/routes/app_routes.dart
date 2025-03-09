import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/presentation/view/forgot_password_verification_view.dart';
import 'package:collabry/features/authentication/presentation/view/forgot_password_view.dart';
import 'package:collabry/features/authentication/presentation/view/login_view.dart';
import 'package:collabry/features/authentication/presentation/view/reset_password_view.dart';
import 'package:collabry/features/authentication/presentation/view/sign_up_verification_view.dart';
import 'package:collabry/features/authentication/presentation/view/sign_up_view.dart';
import 'package:collabry/features/home_page/presentation/views/home_page_view.dart';
import 'package:collabry/features/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route? getAppRoutes(RouteSettings settings) {
    switch (settings.name) {
      //* OnBoardings
      case onBoardingScreen:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());

      //* authentication
      case logInScreen:
        return MaterialPageRoute(builder: (context) => const LogInView());
      case forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordView());
      case forgotPasswordVerificationScreen:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordVerificationView());
      case resetPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordView());
      case signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpView());
      case signUpVerificationScreen:
        return MaterialPageRoute(
            builder: (context) => const SignUpVerificationView());
      //* App Screens
      case homePageScreen:
        return MaterialPageRoute(builder: (context) => const HomePageView());

      default:
        return null;
    }
  }
}
