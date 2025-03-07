import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/presentation/view/login_view.dart';
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

      default:
        return null;
    }
  }
}
