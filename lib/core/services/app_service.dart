import 'package:collabry/core/di/di.dart';
import 'package:collabry/core/functions/extensions/string_extension.dart';
import 'package:collabry/core/services/hive_service.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:hive/hive.dart';

class AppService {
  late Box _firstTimeBox;
  late Box _userBox;
  bool _isLoggedIn = false;
  bool _isInitialized = false;

  Box get firstTimeBox => _firstTimeBox;
  Box get userBox => _userBox;
  bool get isLoggedIn => _isLoggedIn;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    try {
      await setupDependencies();

      _firstTimeBox = await HiveService.openHiveBox(HiveBoxes.firstTimeBox);
      _userBox = await HiveService.openHiveBox(HiveBoxes.userBox);

      await _checkLoginStatus();

      _isInitialized = true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _checkLoginStatus() async {
    try {
      String? token = await secureStorage.read(key: accessTokenKey);
      _isLoggedIn = !token.isNullOrEmpty();
    } catch (e) {
      _isLoggedIn = false;
    }
  }

  void setLoginStatus(bool status) {
    _isLoggedIn = status;
  }

  String getInitialRoute() {
    try {
      if (!_isInitialized) return Routes.logInScreen;

      bool isFirstTime =
          _firstTimeBox.get(HiveKeys.kFirstTime, defaultValue: true);

      if (isFirstTime) {
        return Routes.onBoardingScreen;
      } else if (_isLoggedIn) {
        return Routes.mainPageScreen;
      } else {
        return Routes.logInScreen;
      }
    } catch (e) {
      return Routes.logInScreen;
    }
  }
}
