import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/colors.dart'; // <- adjust to your actual path

class AppThemes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'cairo',
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.primaryText,
      titleTextStyle: TextStyle(
        fontFamily: 'cairo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryText,
      ),
      centerTitle: true,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardColor,
      elevation: 0,
      selectedItemColor: AppColors.amber,
      unselectedItemColor: AppColors.secondaryText,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.cardColor,
      filled: true,
      suffixIconColor: AppColors.amber,
      prefixIconColor: AppColors.amber,
      hintStyle: TextStyle(
        fontSize: 15,
        color: AppColors.secondaryText,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryText),
      bodyMedium: TextStyle(color: AppColors.secondaryText),
    ),
    colorScheme: const ColorScheme.dark(
      background: AppColors.background,
      surface: AppColors.cardColor,
      primary: AppColors.primaryText,
      onPrimary: AppColors.primaryText,
      onSurface: AppColors.primaryText,
    ),
  );
}
