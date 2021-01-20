
// =========================GOOGLE 
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_google/vista/inicio_vista.dart';

import 'dart:convert';
import 'constants/app_themes.dart';
import 'controlador/theme_controller.dart';
 
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<ThemeController>(ThemeController());

  runApp(MyApp());
}
 
  
String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class MyApp extends StatelessWidget {

  static final String title = 'LOGIN';

  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      title: title,        
      home: InicioVista(),
    );
  }

}


