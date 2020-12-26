

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_google/vista/login_vista.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

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
    // FirebaseAuth auth = FirebaseAuth.instance;
    final user = FirebaseAuth.instance.currentUser;

    sharedPreferences = await SharedPreferences.getInstance();

    // DEBERIA VERIFICAR GOOGLE
    if(user == null){
      print("DEBERIA VERIFICAR GOOGLEDEBERIA VERIFICAR GOOGLE");
      Get.off(LoginVista());
    }
    print("no entro al null jjajajjajaj");

    // DEBERIA VERIFICAR EMAIL
    // if(   sharedPreferences.getString("token") == null) {

    //   Get.off(LoginVista());
    // }


    // DEBERIA VERIFICAR FACEBOOK
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InicioVista '),
        actions: [
          FlatButton(
            onPressed: () { 
              sharedPreferences.clear();
              Get.off(LoginVista());
            },
            child: Text("Salir", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),      
      body: Text('estoy armando LOGIN GOOGLE FACEBOOK EMAIL'),
    );
  }
}