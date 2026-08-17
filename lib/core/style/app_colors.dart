import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color white;
  final Color darkBlue;
  final Color middleBlue;
  final Color lightBlue;
  final Color black;
  final Color grey;
  final Color error;
  final Color green;
  final Color fieldBorder;

  const AppColors({
    required this.white,
    required this.darkBlue,
    required this.middleBlue,
    required this.lightBlue,
    required this.black,
    required this.grey,
    required this.error,
    required this.green,
    required this.fieldBorder,
  });


  static const light = AppColors(
    white: Colors.white,
    darkBlue: Color(0xFF19183B),
    middleBlue: Color(0xFF4441A1),
    lightBlue: Color(0xFFE7F2EF),
    black: Colors.black,
    grey: Color.fromARGB(25, 24, 59, 52),
    error: Color(0xFFDC2626),
    green: Color(0xffBDD9D5),
    fieldBorder: Color(0xff8DA6B6),
  );


  static const dark = AppColors(
    white: Color(0xFF15141F),
    darkBlue: Color(0xFFC9C7EC),
    middleBlue: Color(0xFF6C69C9),
    lightBlue: Color(0xFF1B2E2A),
    black: Color(0xFFF2F2F2),
    grey: Color.fromARGB(40, 255, 255, 255),
    error: Color(0xFFEF5350),
    green: Color(0xFF25423D),
    fieldBorder: Color(0xFF7C93A3),
  );

  @override
  AppColors copyWith({
    Color? white,
    Color? darkBlue,
    Color? middleBlue,
    Color? lightBlue,
    Color? black,
    Color? grey,
    Color? error,
    Color? green,
    Color? fieldBorder,
  }) {
    return AppColors(
      white: white ?? this.white,
      darkBlue: darkBlue ?? this.darkBlue,
      middleBlue: middleBlue ?? this.middleBlue,
      lightBlue: lightBlue ?? this.lightBlue,
      black: black ?? this.black,
      grey: grey ?? this.grey,
      error: error ?? this.error,
      green: green ?? this.green,
      fieldBorder: fieldBorder ?? this.fieldBorder,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      white: Color.lerp(white, other.white, t)!,
      darkBlue: Color.lerp(darkBlue, other.darkBlue, t)!,
      middleBlue: Color.lerp(middleBlue, other.middleBlue, t)!,
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t)!,
      black: Color.lerp(black, other.black, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      error: Color.lerp(error, other.error, t)!,
      green: Color.lerp(green, other.green, t)!,
      fieldBorder: Color.lerp(fieldBorder, other.fieldBorder, t)!,
    );
  }
}

// اختصار    Theme.of(context).extension<AppColors>()! بكل مكان
//  بكفي نكتب: context.colors.darkBlue

extension AppColorsContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}