import 'package:collabry/core/cubit/auth_cubit.dart';
import 'package:collabry/core/utils/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/presentation/view/forgot_password_verification_view.dart';
import 'package:collabry/features/authentication/presentation/view/forgot_password_view.dart';
import 'package:collabry/features/authentication/presentation/view/login_view.dart';
import 'package:collabry/features/authentication/presentation/view/reset_password_view.dart';
import 'package:collabry/features/authentication/presentation/view/sign_up_verification_view.dart';
import 'package:collabry/features/authentication/presentation/view/sign_up_view.dart';
import 'package:collabry/features/community/presentation/views/community_view.dart';
import 'package:collabry/features/home_page/presentation/views/main_page_view.dart';
import 'package:collabry/features/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  Route? getAppRoutes(RouteSettings settings) {
    switch (settings.name) {
      //* OnBoardings
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());

      //* authentication
      case Routes.logInScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => getIt.get<AuthCubit>(),
            child: const LogInView(),
          ),
        );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<AuthCubit>(
                  create: (context) => getIt.get<AuthCubit>(),
                  child: const ForgotPasswordView(),
                ));
      case Routes.forgotPasswordVerificationScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<AuthCubit>(
                  create: (context) => getIt.get<AuthCubit>(),
                  child: const ForgotPasswordVerificationView(),
                ));
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => getIt.get<AuthCubit>(),
            child: const ResetPasswordView(),
          ),
        );

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => getIt.get<AuthCubit>(),
            child: const SignUpView(),
          ),
        );
      case Routes.signUpVerificationScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<AuthCubit>(
                  create: (context) => getIt.get<AuthCubit>(),
                  child: const SignUpVerificationView(),
                ));
      //* App Screens
      case Routes.homePageScreen:
        return MaterialPageRoute(builder: (context) => const MainPageView());

      case Routes.communityPageScreen:
        return MaterialPageRoute(builder: (context) => const CommunityView());

      default:
        return null;
    }
  }
}
