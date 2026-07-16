import 'package:flutter/material.dart';

import 'core/style/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
       theme: AppStyle.lightTheme,
      home: const Scaffold(body: Center(
          child: Text('Task ManAgement System'),
        ),),
    );
  }
}

