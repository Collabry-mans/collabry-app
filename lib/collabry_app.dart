import 'package:collabry/core/di/di.dart';
import 'package:collabry/core/theme/cubit/theme_cubit.dart';
import 'package:collabry/core/theme/presentation/theme_data_dark.dart';
import 'package:collabry/core/theme/presentation/theme_data_light.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'package:collabry/core/routes/app_routes.dart';
import 'package:collabry/core/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Collabry extends StatelessWidget {
  const Collabry({super.key});
  @override
  Widget build(BuildContext context) {
    AppRoutes appRoutes = AppRoutes();
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileCubit>(
          create: (_) {
            final cubit = getIt<UserProfileCubit>();
            if (appService.isLoggedIn) {
              cubit.getUserProfile();
            }
            return cubit;
          },
        ),
        BlocProvider<ThemeCubit>(create: (_) => getIt<ThemeCubit>())
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (_, newTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            theme: getLightTheme(),
            darkTheme: getDarkTheme(),
            themeMode: newTheme,
            onGenerateRoute: appRoutes.getAppRoutes,
            initialRoute: appService.getInitialRoute(),
          );
        },
      ),
    );
  }
}
