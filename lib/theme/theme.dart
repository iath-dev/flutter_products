import 'package:flutter/material.dart';
import 'package:flutter_products/theme/color_schemes.dart';

class AppTheme {
  static ThemeData theme =
      ThemeData.light().copyWith(colorScheme: lightColorScheme);

  static ThemeData darkTheme = theme.copyWith(colorScheme: darkColorScheme);
}
