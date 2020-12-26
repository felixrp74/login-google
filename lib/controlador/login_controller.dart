 
import 'dart:convert';

// import 'package:login_google/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:login_google/vista/inicio_vista.dart';
import 'package:login_google/vista/login_vista.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
   
  LoginController({
        this.name,
        this.email,
        this.password,
    });

  String name;
  String email;
  String password;


  // instancia de goolge
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  SharedPreferences sharedPreferences;


  // here we go 
  String urlRegistrar = "http://192.168.0.103:8000/api/register";
  
  @override
  void onReady(){
    super.onReady();
    print("ON READY REGISTRAR");

  }

























  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    
    this.enviarLaravel();

    // enrutar a inicio_vista.dart
    Get.to(InicioVista());
  }


  void enviarLaravel () async{    
    final user = FirebaseAuth.instance.currentUser;
    print("------------------------->${user.displayName}===================");
    // String url = 'http://127.0.0.1:8000/api/logingoogle';
    // String urlReemplazo = 'http://192.168.0.103:8000/api/logingoogle';
    String urlReemplazo = 'http://192.168.0.106:8000/api/logingoogle';

    http.Response res = await http.post(
      // EL PROBLEMA ES QUE SE ADMITE COMUNICAION ENTRE FLUTER Y LARAVEL
      // CON EL HOST http://127.0.0.1:8000
      // 'http://127.0.0.1:8000/api/logingoogle?name=lio&email=mesi%40'
      urlReemplazo,
      body: {
        'name': user.displayName,
        'email': user.email,
      }
    );

    print("------------------------codigo estado= ${res.statusCode}" );
    if (res.statusCode == 500){
      print("email ya existe");
    }


  }



  void logout() async {
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(   sharedPreferences.getString("token") != null) {
      String valor = sharedPreferences.getString("token");
      print("TOKEN=========== $valor");
      sharedPreferences.clear();
      Get.off(LoginVista());
    } else if (googleSignIn != null){
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();

      print("GOOGLE SALIR");
      Get.off(LoginVista());
    } else {
      Get.snackbar("SALIR", "ERROR");
    }
  }
















 

  Future<http.Response> registrar() async {
     
    print("$name");
    print("$email");
    print("$password");

    http.Response res = await http.post(
      'http://192.168.0.106:8000/api/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password
      }),
      
    ); 


    print("=============REGISTRAR JAJAJAS============");

    if ( res.statusCode == 200 ) {
      print("=============DANCING============");
      this.signIn(email, password);
      // Get.to(InicioVista());

    }else {
      print("=============NO REGISTRO============");
      throw "cant register";
    }
  }


 













  // GOOGLE 
  // Future<http.Response> registrarGoogle() async {
     
  //   print("$name");
  //   print("$email");
  //   // print("$password");

  //   http.Response res = await http.post(
  //     'http://192.168.0.106:8000/api/logingoogle',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },

  //     body: jsonEncode(<String, String>{
  //       'name': name,
  //       'email': email,
  //       // 'password': password
  //     }),
      
  //   ); 


  //   print("=============REGISTRAR GOOGLE============");

  //   if ( res.statusCode == 200 ) {
  //     print("=============google============");
  //     this.signIn(name, password);
  //     // Get.to(InicioVista());

  //   }else {
  //     print("=============NO REGISTRO============");
  //     throw "cant register";
  //   }
  // }


















  void signIn(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass
    };
    var jsonResponse ;

    var response = await http.post("http://192.168.0.106:8000/api/login", body: data);
    // var response = await http.post("http://192.168.0.108:8000/api/login", body: data);
    // var response = await http.post("http://192.168.43.104:8000/api/login", body: data);

    // print()
    if(response.statusCode == 201) { 
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if(jsonResponse != null) {        

        sharedPreferences.setString("token", jsonResponse['token']);

        String toke=sharedPreferences.getString("token");
        print("======CONTROLLER======token=========$toke=============");
        
        Get.off(InicioVista());
      }
    }
    else {
       
      print(response.body);
    }
  }











  // GOOGLE
  void iniciarGoogle( ) async {
    try{
      
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      await _googleSignIn.signIn();
      String email = _googleSignIn.currentUser.displayName.toString();
      String password = _googleSignIn.currentUser.email.toString();
      this.signIn(email, password);
      // Text(_googleSignIn.currentUser.displayName),
                  // Text(_googleSignIn.currentUser.email),
      print('===========GOOGLE HECHO====');
        
    } catch (err){
      print(err);
    }
  }

















  factory LoginController.fromJson(Map<String, dynamic> json) => LoginController(
      name: json["name"],
      email: json["email"],
      password: json["password"],
  );

  Map<String, dynamic> toJson() => {
      "name": name,
      "email": email,
      "password": password,
  };

}