import 'package:collabry/core/routes/app_routes.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/main.dart';
import 'package:flutter/material.dart';

class Collabry extends StatelessWidget {
  const Collabry({super.key});
  @override
  Widget build(BuildContext context) {
    bool isFirstTime = firstTimeBox!.get(kFirstTime, defaultValue: true);
    AppRoutes appRoutes = AppRoutes();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes.getAppRoutes,
      initialRoute: isFirstTime
          ? Routes.onBoardingScreen
          : isLoggedIn
              ? Routes.homePageScreen
              : Routes.logInScreen,
    );
  }
}
