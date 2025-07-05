import 'package:collabry/core/functions/extensions/custom_color_extension.dart';
import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  bool get isDark {
    return Theme.of(this).brightness == Brightness.dark;
  }

  CustomColors get customColors {
    return Theme.of(this).customColors;
  }
}
