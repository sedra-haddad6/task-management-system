import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart'; 

import 'core/services/theme/controller.dart';
import 'core/routes/routes.dart';
import 'core/style/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  await Get.putAsync(() => ThemeController().init());
 
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale:   Locale('en'),
      startLocale: const Locale('en'), 
      saveLocale: true,
      //nothing
      
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
      darkTheme: AppStyle.darkTheme,
      themeMode: Get.find<ThemeController>().isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,

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