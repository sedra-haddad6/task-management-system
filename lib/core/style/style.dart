import 'package:flutter/material.dart';

import 'repo.dart';
 //TODO add styles to the sign up and the login
abstract class AppStyle {

  static ThemeData get lightTheme {
  return ThemeData(

    useMaterial3: true,

    scaffoldBackgroundColor: StyleRepo.white,

    primaryColor: StyleRepo.darkBlue,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),

        backgroundColor: StyleRepo.darkBlue,

        foregroundColor: StyleRepo.white,

        elevation: 8,

        shadowColor: StyleRepo.darkBlue.withOpacity(.25),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(

      filled: true,

      fillColor: StyleRepo.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: StyleRepo.fieldBorder,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: StyleRepo.fieldBorder,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: StyleRepo.darkBlue,
          width: 1.7,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: StyleRepo.error,
        ),
      ),
    ),

    textTheme: const TextTheme(

      headlineMedium: TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.bold,
        color: StyleRepo.darkBlue,
      ),

      bodyMedium: TextStyle(
        fontSize: 15,
        color: StyleRepo.black,
      ),
    ),
  );
}



}
