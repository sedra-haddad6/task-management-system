import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

abstract class Validator {
  static String? notNull(dynamic value) {
    if (value == null || (value is String && value.trim().isEmpty)) {
      return 'validation.required'.tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String? error = notNull(value);
    if (error != null) return error;

    if (!GetUtils.isEmail(value!)) {
      return 'validation.invalid_email'.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    String? error = notNull(value);
    if (error != null) return error;

    if (value!.length < 6) {
      return 'validation.password_length'.tr();
    }
    return null;
  }

  static String? Function(String?) validateConfirmPassword(
    TextEditingController password,
  ) {
    return (value) {
      String? error = notNull(value);
      if (error != null) return error;

      if (value != password.text) {
        return 'validation.password_mismatch'.tr();
      }
      return null;
    };
  }
}