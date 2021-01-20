
import 'dart:convert';
 
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_google/vista/inicio_vista.dart';

class RegistradorControlador extends GetxController {
  
  RegistradorControlador({
        this.name,
        this.email,
        this.password,
    });

  String name;
  String email;
  String password;


  // here we go 
  String urlRegistrar = "http://192.168.0.103:8000/api/register";
 
  // =================EJEMPLO DART
  
  @override
  void onReady(){
    super.onReady();
    print("ON READY REGISTRAR");
   
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
      Get.to(InicioVista());

    }else {
      print("=============REGISTER============");
      throw "NO register";
    }
  }



















  factory RegistradorControlador.fromJson(Map<String, dynamic> json) => RegistradorControlador(
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