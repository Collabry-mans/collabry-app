import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/cubit/auth/auth_cubit.dart';
import 'package:collabry/core/cubit/category/category_cubit.dart';
import 'package:collabry/core/cubit/publication/publication_cubit.dart';
import 'package:collabry/core/cubit/user/user_profile_cubit.dart';
import 'package:collabry/core/database/secure_storage.dart';
import 'package:collabry/features/authentication/data/repository/auth_repository.dart';
import 'package:collabry/features/home_page/data/repository/category_repository.dart';
import 'package:collabry/features/home_page/data/repository/publication_repository.dart';
import 'package:collabry/features/profile/data/repository/user_profile_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;
Future<void> setupDependencies() async {
//* Local Storage
  getIt.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService());

//* API
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer());

  // Register AuthRepository
  getIt.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(dio: getIt<DioConsumer>()),
  );

  // Register AuthCubit as a factory
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<BaseAuthRepository>()),
  );

  // Register PublicationRepo
  getIt.registerLazySingleton<PublicationRepoBase>(
    () => PublicationRepo(dio: getIt<DioConsumer>()),
  );

  // Register PublicationCubit as factory
  getIt.registerFactory<PublicationCubit>(
    () => PublicationCubit(getIt<PublicationRepoBase>()),
  );

  // Register CategoryRepo
  getIt.registerLazySingleton<CategoryRepositoryBase>(
    () => CategoryRepo(dio: getIt<DioConsumer>()),
  );

  // Register CategoryCubit as factory
  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(getIt<CategoryRepositoryBase>()),
  );

  // Register userProfileRepo
  getIt.registerLazySingleton<UserProfileRepositoryBase>(
    () => UserProfileRepo(dio: getIt<DioConsumer>()),
  );

  // Register userProfileCubit as factory
  getIt.registerFactory<UserProfileCubit>(
    () => UserProfileCubit(getIt<UserProfileRepositoryBase>()),
  );
}

SecureStorageService get secureStorage => getIt<SecureStorageService>();
