import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_typography.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF6750A4);
  static const Color primaryPurpleLight = Color.fromARGB(255, 204, 189, 244);
  static const Color secondaryColor = Color(0xFF625B71);

  static const Color lightBackgroundColor = Color(0xFFFDFDFD);
  static const Color lightInputBackgroundColor = Color.fromARGB(
    255,
    225,
    225,
    225,
  );
  static const Color darkBackgroundColor = Color.fromARGB(255, 46, 46, 46);
  static const Color darkInputBackgroundColor = Color.fromARGB(255, 62, 62, 62);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: .light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryPurple,
      brightness: .light,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    textTheme: AppTypography.defaultTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: lightBackgroundColor,
      foregroundColor: darkBackgroundColor,
      titleTextStyle: AppTypography.defaultTextTheme.displaySmall?.copyWith(
        color: primaryPurple,
      ),
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightInputBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: .none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: const BorderSide(color: primaryPurple, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: .none,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: AppTypography.defaultTextTheme.titleMedium,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      trackGap: 3,
      strokeCap: .round,
      circularTrackColor: Colors.grey.shade300,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: .dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryPurpleLight,
      brightness: .dark,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackgroundColor,
      foregroundColor: lightBackgroundColor,
      titleTextStyle: AppTypography.defaultTextTheme.displaySmall?.copyWith(
        color: primaryPurpleLight,
      ),
      centerTitle: false,
    ),
    textTheme: AppTypography.defaultTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkInputBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: .none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: const BorderSide(color: primaryPurpleLight, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: .none,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: AppTypography.defaultTextTheme.titleMedium,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      trackGap: 3,
      strokeCap: .round,
      circularTrackColor: Colors.grey.shade300,
    ),
  );
}
