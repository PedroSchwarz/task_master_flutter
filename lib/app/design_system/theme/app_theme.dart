import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/app/design_system/theme/app_typography.dart';

class AppTheme {
  static const Color primaryRed = Color(0xFFB71C1C);
  static const Color secondaryColor = Color(0xFFE57373);
  static const Color lightBackgroundColor = Color(0xFFFDFDFD);
  static const Color lightInputBackgroundColor = Color.fromARGB(255, 225, 225, 225);
  static const Color darkBackgroundColor = Color.fromARGB(255, 46, 46, 46);
  static const Color darkInputBackgroundColor = Color.fromARGB(255, 62, 62, 62);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryRed,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryRed,
      brightness: Brightness.light,
      primary: primaryRed,
      onPrimary: lightBackgroundColor,
      secondary: secondaryColor,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    textTheme: AppTypography.defaultTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: lightBackgroundColor,
      foregroundColor: darkBackgroundColor,
      titleTextStyle: AppTypography.defaultTextTheme.displaySmall?.copyWith(color: primaryRed),
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
      filled: true,
      fillColor: lightInputBackgroundColor,
    ),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(textStyle: AppTypography.defaultTextTheme.titleMedium)),
    progressIndicatorTheme: ProgressIndicatorThemeData(trackGap: 3, strokeCap: StrokeCap.round, circularTrackColor: Colors.grey.shade300),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryRed,
      brightness: Brightness.dark,
      primary: primaryRed,
      onPrimary: lightBackgroundColor,
      secondary: secondaryColor,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackgroundColor,
      foregroundColor: lightBackgroundColor,
      titleTextStyle: AppTypography.defaultTextTheme.displaySmall?.copyWith(color: primaryRed),
      centerTitle: false,
    ),
    textTheme: AppTypography.defaultTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: lightBackgroundColor, width: 2),
        borderRadius: BorderRadius.circular(AppSpacing.xs),
      ),
      filled: true,
      fillColor: darkInputBackgroundColor,
    ),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(textStyle: AppTypography.defaultTextTheme.titleMedium)),
    progressIndicatorTheme: ProgressIndicatorThemeData(trackGap: 3, strokeCap: StrokeCap.round, circularTrackColor: Colors.grey.shade300),
  );
}
