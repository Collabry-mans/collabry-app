import 'package:collabry/collabry_app.dart';
import 'package:collabry/core/functions/extensions.dart';
import 'package:collabry/core/services/simple_bloc_observer.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

bool isLoggedIn = false;
Box? firstTimeBox, userBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  firstTimeBox = await openHiveBox(firstTimeBoxName);
  userBox = await openHiveBox(userBoxName);
  await isLoggedInChecker();
  Bloc.observer = SimpleBlocObserver();

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

Future<void> isLoggedInChecker() async {
  String? token = await secureStorage.read(key: accessTokenKey);

  !token.isNullOrEmpty() ? isLoggedIn = true : isLoggedIn = false;
}

Future<Box> openHiveBox(String boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxName);
}
