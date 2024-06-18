import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/text_style_extension.dart';

import '../../main.dart';

part 'light/light_theme.dart';

part 'dark/dark_theme.dart';

@lazySingleton
class ThemeConfig {
  // final ThemeData _lightTheme = _getLightTheme();
  // final ThemeData _darkTheme = _getDarkTheme();

  ThemeData get lightTheme => _getLightTheme();

  ThemeData get darkTheme => _getDarkTheme();
}
