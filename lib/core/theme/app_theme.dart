import 'package:chat_ai_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FontSize {
  static const double extraSmall = 13;
  static const double small = 14;
  static const double medium = 16;
  static const double standard = 18;
  static const double large = 20;
  static const double extraLarge = 24;
  static const double extraExtraLarge = 26;
}

ThemeData lightModeTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.whiteColor,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: AppColors.blackColor),
    backgroundColor: AppColors.whiteColor,
    elevation: 1,
    centerTitle: false,
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.whiteColor,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w800,
      fontSize: FontSize.large,
    ),
    bodyMedium: TextStyle(
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w600,
      fontSize: FontSize.medium,
    ),
    bodySmall: TextStyle(
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w400,
      fontSize: FontSize.small,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(
        AppColors.primaryColor,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: FontSize.large,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.whiteLightColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: AppColors.redColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: AppColors.redColor,
      ),
    ),
    hintStyle: const TextStyle(
      color: AppColors.greyLightColor,
      fontWeight: FontWeight.w600,
      fontSize: FontSize.extraSmall,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
  ),
);
ThemeData darkModeTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.blackColor,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: AppColors.whiteColor),
    backgroundColor: AppColors.blackColor,
    elevation: 1,
    centerTitle: false,
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.whiteColor,
    brightness: Brightness.dark,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w800,
      fontSize: FontSize.large,
    ),
    bodyMedium: TextStyle(
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w600,
      fontSize: FontSize.medium,
    ),
    bodySmall: TextStyle(
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w400,
      fontSize: FontSize.small,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(
        AppColors.primaryColor,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: FontSize.large,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.whiteLightColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: AppColors.redColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: AppColors.redColor,
      ),
    ),
    hintStyle: const TextStyle(
      color: AppColors.greyLightColor,
      fontWeight: FontWeight.w600,
      fontSize: FontSize.extraSmall,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
  ),
);
