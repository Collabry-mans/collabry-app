import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/main.dart';
import 'package:flutter/material.dart';

class ThemeService {
  Future<ThemeMode> getSavedTheme() async {
    final themeBox = await openHiveBox(HiveBoxes.themeBox);
    final String theme =
        themeBox.get(HiveKeys.kTheme, defaultValue: ThemeMode.system.name);
    return ThemeMode.values.byName(theme);
  }

  Future<void> saveTheme(ThemeMode theme) async {
    final themeBox = await openHiveBox(HiveBoxes.themeBox);
    await themeBox.put(HiveKeys.kTheme, theme.name);
  }
}
