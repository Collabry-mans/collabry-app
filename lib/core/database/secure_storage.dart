import 'package:collabry/core/utils/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage secureStorage;
  SecureStorageService()
      : secureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        );

  Future<void> write({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return await secureStorage.read(key: key);
  }

  Future<void> deleteAll() async {
    await secureStorage.delete(key: accessTokenKey);
    await secureStorage.delete(key: refreshTokenKey);
  }
}
