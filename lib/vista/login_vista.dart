import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_google/controlador/login_controller.dart';
import 'package:login_google/vista/inicio_vista.dart';
import 'package:login_google/vista/registrar_vista.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class LoginVista extends StatefulWidget {
    
  @override
  _LoginVistaState createState() => _LoginVistaState();
}

class _LoginVistaState extends State<LoginVista> {
  
 








  
   bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

    return GetBuilder<LoginController>( 
      init: LoginController(),
      builder: (_) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.teal],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: _isLoading ? Center(child: CircularProgressIndicator()) : 
            ListView(
              children: <Widget>[
                headerSection(),
                textSection(),
                buttonSection(_),
                buttonRegistrar(),
                buttonFacebook(_),
                buttonGoogle(_),
              ],
            ),
          ),
        );
      },
      
    );
  }

  
  // signIn(String email, pass) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map data = {
  //     'email': email,
  //     'password': pass
  //   };
  //   var jsonResponse ;

  //   var response = await http.post("http://192.168.0.106:8000/api/login", body: data);
  //   // var response = await http.post("http://192.168.0.108:8000/api/login", body: data);
  //   // var response = await http.post("http://192.168.43.104:8000/api/login", body: data);

  //   // print()
  //   if(response.statusCode == 201) { 
  //     jsonResponse = json.decode(response.body);
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if(jsonResponse != null) {
  //       setState(() {
  //         _isLoading = false;
  //       });

  //       sharedPreferences.setString("token", jsonResponse['token']);

  //       String toke=sharedPreferences.getString("token");
  //       print("============token=========$toke=============");
        
  //       Get.off(InicioVista());
  //     }
  //   }
  //   else {
  //     setState(() {
  //       _isLoading = false;
  //       }
  //     );
  //     print(response.body);
  //   }
  // }

  Container buttonSection(LoginController _) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          _.signIn(emailController.text, passwordController.text);
        },
        // onPressed: (){
        //   setState(() {
        //     _isLoading = true;
        //   });
        //   signIn(emailController.text, passwordController.text);
        // },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Iniciar email", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
  
  Container buttonRegistrar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed:  () { 
          Get.to(RegistrarVista()); 
          
        },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Registrar", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }















  Container buttonFacebook(LoginController _) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed:  () {


          _.signInWithFacebook();
           
        },
        elevation: 0.0,
        color: Colors.green,
        child: Text("Facebook", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
  























  Container buttonGoogle(LoginController _) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed:  () {


          // _.name = _googleSignIn.currentUser.displayName;
          // _.email = _googleSignIn.currentUser.email;
          // _.password = 'GOOGLE'; 

          _.signInWithGoogle();
          
          // print("===========================${_.name}========");
          // print("===========================${_.email}========");
           
          // _.registrar();

          // _.iniciarGoogle();
        },
        elevation: 0.0,
        color: Colors.blue,
        child: Text("Google", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
  





















  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("APICITO",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 40.0,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }

}