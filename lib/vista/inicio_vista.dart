

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_google/vista/login_vista.dart';
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
    // instancia de goolge
    final google = FirebaseAuth.instance.currentUser;
    sharedPreferences = await SharedPreferences.getInstance();

    if ( google != null ){ 
      print('google iniciado');
    } else if ( sharedPreferences.getString("token") != null ){
      print("email iniciado");
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
                  print("SALIR");

                  _.logout();


                },
                child: Text("Salir", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),      
          body: Text('estoy armando LOGIN GOOGLE FACEBOOK EMAIL'),
        );
      }
    );
    
  }
}