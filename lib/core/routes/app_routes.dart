import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/on_boarding/presentation/widgets/onboarding1_view.dart';
import 'package:collabry/features/on_boarding/presentation/widgets/onboarding2_view.dart';
import 'package:collabry/features/on_boarding/presentation/widgets/onboarding3_view.dart';
import 'package:collabry/features/on_boarding/presentation/widgets/onboarding4_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route? getAppRoutes(RouteSettings settings) {
    switch (settings.name) {
      //* OnBoardings
      case onBoarding1:
        return MaterialPageRoute(builder: (context) => const Onboarding1View());
      case onBoarding2:
        return MaterialPageRoute(builder: (context) => const Onboarding2View());
      case onBoarding3:
        return MaterialPageRoute(builder: (context) => const Onboarding3View());
      case onBoarding4:
        return MaterialPageRoute(builder: (context) => const Onboarding4View());
      //* authentication
      default:
        return null;
    }
  }
}
