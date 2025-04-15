import 'package:collabry/core/cubit/user/user_profile_cubit.dart';
import 'package:collabry/core/routes/app_routes.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Collabry extends StatelessWidget {
  const Collabry({super.key});
  @override
  Widget build(BuildContext context) {
    bool isFirstTime = firstTimeBox!.get(kFirstTime, defaultValue: true);
    AppRoutes appRoutes = AppRoutes();
    return BlocProvider(
      create: (context) {
        final cubit = getIt<UserProfileCubit>();
        if (isLoggedIn) {
          cubit.getUserProfile();
        }
        return cubit;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRoutes.getAppRoutes,
        initialRoute: isFirstTime
            ? Routes.onBoardingScreen
            : isLoggedIn
                ? Routes.mainPageScreen
                : Routes.logInScreen,
      ),
    );
  }
}
