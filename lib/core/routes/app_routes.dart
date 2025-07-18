import 'package:collabry/features/authentication/presentation/manager/auth_cubit.dart';
import 'package:collabry/features/home_page/presentation/manager/category/category_cubit.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/core/di/di.dart';
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
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:collabry/features/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:collabry/features/profile/presentation/views/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  Route? getAppRoutes(RouteSettings settings) {
    switch (settings.name) {
      //* OnBoardings
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      //* authentication
      case Routes.logInScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(),
            child: const LogInView(),
          ),
        );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthCubit>(
                  create: (_) => getIt<AuthCubit>(),
                  child: const ForgotPasswordView(),
                ));
      case Routes.forgotPasswordVerificationScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthCubit>(
                  create: (_) => getIt<AuthCubit>(),
                  child: const ForgotPasswordVerificationView(),
                ));
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(),
            child: const ResetPasswordView(),
          ),
        );

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(),
            child: const SignUpView(),
          ),
        );

      case Routes.signUpVerificationScreen:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: SignUpVerificationView(email: email),
          ),
        );

      //* App Screens
      case Routes.mainPageScreen:
        return MaterialPageRoute(builder: (_) => const MainPageView());

      case Routes.createPublicationScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<PublicationCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<CategoryCubit>(),
              ),
            ],
            child: const CreatePublicationView(),
          ),
        );

      case Routes.publicationByIdScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final type = args['type'] as PostTileType;
        final publicationId = args['publicationId'] as String;

        return MaterialPageRoute(
          builder: (_) => BlocProvider<PublicationCubit>.value(
            value: args['cubit'] as PublicationCubit,
            child:
                PublicationByIdView(publicationId: publicationId, type: type),
          ),
        );

      case Routes.userProfileScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<PublicationCubit>(),
                  child: const UserProfileView(),
                ));
      default:
        return null;
    }
  }
}
