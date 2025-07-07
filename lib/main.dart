import 'package:collabry/collabry_app.dart';
import 'package:collabry/core/di/di.dart';
import 'package:collabry/simple_bloc_observer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appService.initialize();
  Bloc.observer = SimpleBlocObserver();

  runApp(
    DevicePreview(
      enabled: true,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => const Collabry(),
    ),
  );
}
