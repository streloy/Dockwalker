import 'package:dockwalker/pages/auth/auth_page.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dockwalker/utils/AppTheme.dart';
import 'package:flutter_quill/flutter_quill.dart';


void main() async {
  Get.lazyPut<HomeService>(()=> HomeService());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dockwalker',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
      ],
      theme: AppTheme.lightTheme,
      darkTheme: ThemeData.light(),
      themeMode: ThemeMode.dark,
      home: AuthPage(),
    );
  }
}


