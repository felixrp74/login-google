
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:login_google/controlador/login_controller.dart';
import 'package:login_google/vista/registrar_vista.dart';


class LoginVista extends StatefulWidget {
    
  @override
  _LoginVistaState createState() => _LoginVistaState();
}

class _LoginVistaState extends State<LoginVista> {
  
 







 

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
            child: _.isLoading ? Center(child: CircularProgressIndicator()) : 
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

   
  Container buttonSection(LoginController _) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          // setState(() {
            // _._isLoading.value = true;
            _.isLoading = true;
            // update();
          // });
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