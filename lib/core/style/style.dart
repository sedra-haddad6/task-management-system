import 'package:flutter/material.dart';

import 'repo.dart';
 //TODO add styles to the sign up and the login
abstract class AppStyle {
  static ThemeData get lightTheme {
    return ThemeData(

      primaryColor: StyleRepo.darkBlue,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: StyleRepo.darkBlue,
        unselectedItemColor: StyleRepo.black,


      ),






    );
  }
}
