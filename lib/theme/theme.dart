import 'package:flutter/material.dart';
import 'package:flutter_products/theme/color_schemes.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
      colorScheme: lightColorScheme,
      appBarTheme: const AppBarTheme(elevation: 0),
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(), isDense: true));

  static ThemeData darkTheme = theme.copyWith(colorScheme: darkColorScheme);
}
