import 'package:flutter/material.dart';

import 'repo.dart';

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
