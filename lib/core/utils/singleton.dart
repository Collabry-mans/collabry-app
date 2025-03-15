import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/cubit/auth_cubit.dart';
import 'package:collabry/core/utils/secure_storage.dart';
import 'package:collabry/features/authentication/repository/auth_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;
late SecureStorageService secureStorage;
void setupDependencies() async {
//* Local Storage
  secureStorage =
      getIt.registerSingleton<SecureStorageService>(SecureStorageService());

//* API
  getIt.registerSingleton<DioConsumer>(DioConsumer());
  getIt.registerSingleton<BaseAuthRepository>(
      AuthRepository(dio: getIt.get<DioConsumer>()));
  getIt.registerFactory<AuthCubit>(
      () => AuthCubit(getIt.get<BaseAuthRepository>()));
}
