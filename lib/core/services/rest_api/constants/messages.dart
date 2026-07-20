import 'package:easy_localization/easy_localization.dart';
// هدول رسائل خطأ مترجمة already




abstract class APIErrorMessages {
  static String get noInternet => 'errors.no_internet'.tr();
  static String get noData => 'errors.no_data'.tr();
  static String get noAuth => 'errors.no_auth'.tr();
  static String get forbidden => 'errors.forbidden'.tr();
  static String get validation => 'errors.validation'.tr();
  static String get server => 'errors.server'.tr();
  static String get unknown => 'errors.unknown'.tr();
  static String get canceled => 'errors.canceled'.tr();
}