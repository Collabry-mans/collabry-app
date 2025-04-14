import 'package:collabry/core/cubit/auth/auth_cubit.dart';
import 'package:collabry/core/cubit/category/category_cubit.dart';
import 'package:collabry/core/cubit/publication/publication_cubit.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/presentation/view/forgot_password_verification_view.dart';
import 'package:collabry/features/authentication/presentation/view/forgot_password_view.dart';
import 'package:collabry/features/authentication/presentation/view/login_view.dart';
import 'package:collabry/features/authentication/presentation/view/reset_password_view.dart';
import 'package:collabry/features/authentication/presentation/view/sign_up_verification_view.dart';
import 'package:collabry/features/authentication/presentation/view/sign_up_view.dart';
import 'package:collabry/features/home_page/presentation/views/create_publication_view.dart';
import 'package:collabry/features/home_page/presentation/views/main_page_view.dart';
import 'package:collabry/features/home_page/presentation/views/publication_by_id_view.dart';
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
            create: (context) => getIt<AuthCubit>(),
            child: const LogInView(),
          ),
        );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<AuthCubit>(
                  create: (context) => getIt<AuthCubit>(),
                  child: const ForgotPasswordView(),
                ));
      case Routes.forgotPasswordVerificationScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<AuthCubit>(
                  create: (context) => getIt<AuthCubit>(),
                  child: const ForgotPasswordVerificationView(),
                ));
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => getIt<AuthCubit>(),
            child: const ResetPasswordView(),
          ),
        );

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => getIt<AuthCubit>(),
            child: const SignUpView(),
          ),
        );
      case Routes.signUpVerificationScreen:
        final authCubit = settings.arguments as AuthCubit;

        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: authCubit,
            child: const SignUpVerificationView(),
          ),
        );
      //* App Screens
      case Routes.mainPageScreen:
        return MaterialPageRoute(builder: (context) => const MainPageView());

      case Routes.createPublicationScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<PublicationCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<CategoryCubit>(),
              ),
            ],
            child: const CreatePublicationView(),
          ),
        );

      case Routes.publicationByIdScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider<PublicationCubit>.value(
                  value: args['cubit'] as PublicationCubit,
                  child: PublicationByIdView(
                      publicationId: args['publicationId'] as String),
                ));

      default:
        return null;
    }
  }
}
