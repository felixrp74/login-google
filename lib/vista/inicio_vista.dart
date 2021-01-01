

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:login_google/vista/login_vista.dart';
import 'package:login_google/vista/setting_vista.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:login_google/controlador/login_controller.dart';

class InicioVista extends StatefulWidget {
  @override
  _InicioVistaState createState() => _InicioVistaState();
}

class _InicioVistaState extends State<InicioVista> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
      
  }

  checkLoginStatus() async {
    // GOOGLE
    final google = FirebaseAuth.instance.currentUser;

    // EMAIL
    sharedPreferences = await SharedPreferences.getInstance();

    // FACEBOOK
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;

    if ( google != null ){ 
      print('google iniciado');

    } else if ( sharedPreferences.getString("token") != null ){
      print("email iniciado");

    } else if ( accessToken != null ) {
      print("facebook iniciado");

    } else {
        Get.off(LoginVista());
    }


 
  }


 

 

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>( 
      init: LoginController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('InicioVista '),
            actions: [
              FlatButton(
                onPressed: () { 
                  print("salir pressed");
                  _.logout();

                },
                child: Text("Salir", style: TextStyle(color: Colors.white)),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Get.to(SettingsUI());
                }
              ),
            ],
          ),      
          body: Text(
            "estoy armando LOGIN GOOGLE FACEBOOK EMAIL", 
            style: TextStyle(fontSize: 40)
          ),
        );
      }
    );
    
  }
}