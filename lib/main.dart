
// =========================GOOGLE 
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:login_google/vista/inicio_vista.dart';
 
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {

  static final String title = 'LOGIN';

  @override
  Widget build(BuildContext context) => 
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: title,        
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: InicioVista(),
    );

}