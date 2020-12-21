import 'package:flutter/material.dart';
import 'package:login_google/page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';

  @override
  Widget build(BuildContext context) => 
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: title,        
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomePage(),
    );


    // MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: title,        
    //     theme: ThemeData(primarySwatch: Colors.deepOrange),
    //     home: HomePage(),
    //   );
}
 