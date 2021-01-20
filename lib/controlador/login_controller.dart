 
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:login_google/modelo/model_usuario.dart';
import 'package:login_google/vista/inicio_vista.dart';
import 'package:login_google/vista/login_vista.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class LoginController extends GetxController {
  Rx<UsuarioModel> usuario = UsuarioModel(name: "go@go", email: "go@go", password: "go@go" ).obs;
 
  // GOOGLE
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences sharedPreferences;

  // FACEBOOK
  AccessToken _accessToken;
  Map<String, dynamic> _userData;

  // EMAIL
  bool isLoading = false; 
  
  @override
  void onReady(){
    super.onReady();
    print("ON READY REGISTRAR");

  }














 

Future signInWithFacebook() async {

  print("FACEBOOK LOGIN");
  
  // Trigger the sign-in flow
  try {
    _accessToken = await FacebookAuth.instance.login();

    final userData = await FacebookAuth.instance.getUserData();
    _userData = userData;

    print(_userData["name"]);
    print(_userData["email"]);

    usuario.value.name = _userData["name"];
    usuario.value.email = _userData["email"];

    enviarLaravelGoogle();

    Get.off(InicioVista());

  } on FacebookAuthException catch (e) {
      // if the facebook login fails
      print(e.message); // print the error message in console
      // check the error type
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    } finally {
      // update the view
      // setState(() {
      //   _checking = false;
      // });
    }
}



  Future<void> logout() async {

    print("SALIENDO... ");

    final AccessToken accessToken = await FacebookAuth.instance.isLogged;
  
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance(); 

    // if(   sharedPreferences.getString("token") != null ) {
   
      // String valor = sharedPreferences.getString("token");
      // print("TOKEN=========== $valor");
      sharedPreferences.clear();
      print("SALIR EMAIL");
      Get.off(LoginVista());
 

    if ( _auth.currentUser != null ){
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
      print("SALIR GOOGLE");
      Get.off(LoginVista());


    } else if ( accessToken != null ) {
      await FacebookAuth.instance.logOut();
      _accessToken = null;
      Get.off(LoginVista());
      print("SALIR FACEBOOK");

    } else {
      Get.snackbar("SALIR", "ERROR");

    }

    
  }



















  Future signInWithGoogle() async { 
    // =================NUEVO================

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // logear con firebase
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    usuario.value.name = user.displayName;
    usuario.value.email = user.email;

    
    this.enviarLaravelGoogle();

    // enrutar a inicio_vista.dart
    Get.off(InicioVista());
  }


  void enviarLaravelGoogle () async{    
    // final user = FirebaseAuth.instance.currentUser;
    // print("------------------------->${user.displayName}==================="); 
    // this.sharedPreferences.setString("name", user.displayName);

    // String urlReemplazo = 'http://felix.gruposistemas.org/api/logingoogle';
    String urlReemplazo = 'http://192.168.0.106:8000/api/logingoogle';

    http.Response res = await http.post( 
      urlReemplazo,
      body: {
        'name': usuario.value.name,
        'email': usuario.value.email,
      }
    );

    print("codigo estado= ${res.statusCode}" );
    print(res.body);

    if (res.statusCode == 500){
      print("email ya existe");
    }


  }
 



















 

  Future<http.Response> registrar() async {
     
    print("name "+usuario.value.name);
    print("email "+usuario.value.email);
    print("password "+usuario.value.password); 

    http.Response res = await http.post(
      'http://felix.gruposistemas.org/api/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, String>{
        'name': usuario.value.name,
        'email': usuario.value.email,
        'password': usuario.value.password
      }),
      
    ); 


    print("=============REGISTRAR ============");

    if ( res.statusCode == 200 ) {
      print("=============DANCING============");
      this.signIn();

    }else {
      print("=============NO REGISTRO============");
      throw "cant register";
    }
  }


 









 








  void signIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("email "+usuario.value.email);
    print("passs "+usuario.value.password);

    Map data = {
      'email': usuario.value.email,
      'password': usuario.value.password,
    };
    var jsonResponse ;

    String url="http://felix.gruposistemas.org/api/login";

    var response = await http.post(url, body: data); 

    if(response.statusCode == 201) { 
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if(jsonResponse != null) {        

        sharedPreferences.setString("token", jsonResponse['token']);

        String token=sharedPreferences.getString("token");
        print("======CONTROLLER======token=========$token=============");
        
        Get.offAll(InicioVista());
      }
    }
    else {
      print("error login");
      
      isLoading = false;
      Get.off(LoginVista());
      // Get.
      update();
      print(response.body);
    }
  }


 


 

}