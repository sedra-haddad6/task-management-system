import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppStyle {
  static ThemeData get lightTheme =>
      _buildTheme(AppColors.light, Brightness.light);

  static ThemeData get darkTheme =>
      _buildTheme(AppColors.dark, Brightness.dark);

  static ThemeData _buildTheme(
    AppColors colors,
    Brightness brightness,
  ) {
    final isDark = brightness == Brightness.dark;
    final onPrimary = isDark ? colors.black : colors.white;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,

      scaffoldBackgroundColor: colors.white,

      colorScheme: isDark
          ? ColorScheme.dark(
              primary: colors.middleBlue,
              onPrimary: onPrimary,
              secondary: colors.darkBlue,
              onSecondary: onPrimary,
              surface: colors.white,
              onSurface: colors.black,
              error: colors.error,
              onError: onPrimary,
              outline: colors.fieldBorder,
            )
          : ColorScheme.light(
              primary: colors.middleBlue,
              onPrimary: onPrimary,
              secondary: colors.darkBlue,
              onSecondary: onPrimary,
              surface: colors.white,
              onSurface: colors.black,
              error: colors.error,
              onError: onPrimary,
              outline: colors.fieldBorder,
            ),

      primaryColor: colors.middleBlue,

      extensions: <ThemeExtension<dynamic>>[
        colors,
      ],

      appBarTheme: AppBarTheme(
        backgroundColor: colors.white,
        foregroundColor: colors.darkBlue,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),

      dividerTheme: DividerThemeData(
        color: colors.grey,
        thickness: 1,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        hintStyle: TextStyle(
          color: colors.fieldBorder,
        ),
        prefixIconColor: colors.fieldBorder,
        suffixIconColor: colors.fieldBorder,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: colors.fieldBorder,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: colors.fieldBorder,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: colors.darkBlue,
            width: 1.7,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: colors.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: colors.error,
            width: 1.7,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          backgroundColor: colors.middleBlue,
          foregroundColor: onPrimary,
          elevation: 8,
          shadowColor: colors.darkBlue.withOpacity(.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.middleBlue,
        ),
      ),

      iconTheme: IconThemeData(
        color: colors.darkBlue,
      ),

      textTheme: TextTheme(
        headlineMedium: TextStyle(
          fontSize: 31,
          fontWeight: FontWeight.bold,
          color: colors.darkBlue,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          color: colors.black,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.white,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}