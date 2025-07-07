import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/services/app_service.dart';
import 'package:collabry/core/theme/cubit/theme_cubit.dart';
import 'package:collabry/core/theme/data/theme_service.dart';
import 'package:collabry/features/authentication/presentation/manager/auth_cubit.dart';
import 'package:collabry/features/home_page/presentation/manager/category/category_cubit.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'package:collabry/core/services/secure_storage_service.dart';
import 'package:collabry/features/authentication/data/repository/auth_repository.dart';
import 'package:collabry/features/home_page/data/repository/category_repository.dart';
import 'package:collabry/features/home_page/data/repository/publication_repository.dart';
import 'package:collabry/features/profile/data/repository/user_profile_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;
Future<void> setupDependencies() async {
//* Services
  // Register AppService
  getIt.registerLazySingleton<AppService>(() => AppService());
  // Register SecureStorageService
  getIt.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService());

//* API
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer());

//* Authentication
  // Register AuthRepository
  getIt.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(dio: getIt<DioConsumer>()),
  );

  // Register AuthCubit as a factory
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<BaseAuthRepository>()),
  );

//* Publication
  // Register PublicationRepo
  getIt.registerLazySingleton<PublicationRepoBase>(
    () => PublicationRepo(dio: getIt<DioConsumer>()),
  );

  // Register PublicationCubit
  getIt.registerFactory<PublicationCubit>(
    () => PublicationCubit(getIt<PublicationRepoBase>()),
  );

//* Category
  // Register CategoryRepo
  getIt.registerLazySingleton<CategoryRepositoryBase>(
    () => CategoryRepo(dio: getIt<DioConsumer>()),
  );

  // Register CategoryCubit
  getIt.registerLazySingleton<CategoryCubit>(
    () => CategoryCubit(getIt<CategoryRepositoryBase>()),
  );

//* User Profile
  // Register userProfileRepo
  getIt.registerLazySingleton<UserProfileRepositoryBase>(
    () => UserProfileRepo(dio: getIt<DioConsumer>()),
  );

  // Register userProfileCubit
  getIt.registerFactory<UserProfileCubit>(
    () => UserProfileCubit(getIt<UserProfileRepositoryBase>()),
  );

//* Theme
  // Register themeService
  getIt.registerLazySingleton<ThemeService>(() => ThemeService());

  // Register themeCubit
  getIt.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(getIt<ThemeService>()),
  );
}

SecureStorageService get secureStorage => getIt<SecureStorageService>();
AppService get appService => getIt<AppService>();
