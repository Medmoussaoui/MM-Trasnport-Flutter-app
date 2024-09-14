import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';

class AppTheme {
  static final primaryTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1,
      ),
      bodySmall: TextStyle(
        fontSize: 14.5,
        height: 1,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondColor,
    ),
  );
}
