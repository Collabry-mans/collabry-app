import 'package:collabry/collabry_app.dart';
import 'package:collabry/core/functions/extensions.dart';
import 'package:collabry/core/utils/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

bool isLoggedIn = false;
Box? firstTimeBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firstTimeBox = await openHiveBox(firstTimeBoxName);
  setupDependencies();
  isLoggedInChecker();

  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const Collabry(),
    ),
  );
}

void isLoggedInChecker() {
  String? token = secureStorage.read(key: accessTokenKey).toString();
  if (token.isNullOrEmpty()) {
    isLoggedIn = false;
  }
  isLoggedIn = true;
}

Future<Box> openHiveBox(String boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxName);
}
