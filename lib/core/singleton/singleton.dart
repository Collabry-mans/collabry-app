import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/cubit/auth/auth_cubit.dart';
import 'package:collabry/core/database/secure_storage.dart';
import 'package:collabry/core/repositories/auth_repository.dart';
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
}

SecureStorageService get secureStorage => getIt<SecureStorageService>();
