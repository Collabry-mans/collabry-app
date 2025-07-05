import 'package:collabry/core/theme/data/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._themeService) : super(ThemeMode.system) {
    loadTheme();
  }
  final ThemeService _themeService;

  Future<void> toggleTheme(ThemeMode themeMode) async {
    await _themeService.saveTheme(themeMode);
    emit(themeMode);
  }

  Future<void> loadTheme() async {
    final savedTheme = await _themeService.getSavedTheme();
    emit(savedTheme);
  }
}
