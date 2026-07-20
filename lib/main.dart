import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import 'core/routes/routes.dart';
import 'core/style/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale:  Locale('en'),
      startLocale: const Locale('en'),

      // TODO بس يصير في زر تغيير اللغة منضيفه 
      // عن طريق: context.setLocale(Locale('ar'));
      
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app_name'.tr(),
      theme: AppStyle.lightTheme,

      // Internationalization

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,


      // Routing

      getPages: AppRouting.pages,
      initialRoute: AppRouting.initialRoute.name,
    );
  }
}