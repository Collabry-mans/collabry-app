import 'package:collabry/core/routes/app_routes.dart';
import 'package:collabry/core/singletons/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box? firstTimeBox;

Future<Box> openHiveBox(String boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxName);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firstTimeBox = await openHiveBox(firstTimeBoxName);
  setupDependencies();

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

class Collabry extends StatelessWidget {
  const Collabry({super.key});
  @override
  Widget build(BuildContext context) {
    bool isFirstTime = firstTimeBox!.get(kFirstTime, defaultValue: true);
    AppRoutes appRoutes = AppRoutes();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes.getAppRoutes,
      initialRoute: isFirstTime ? onBoardingScreen : logInScreen,
    );
  }
}
