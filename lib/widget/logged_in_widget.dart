import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_google/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class LoggedInWidget extends StatefulWidget {
 
  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {

  //sin GETX la guncion initState()
  void initState() {
    super.initState();
     enviarLaravel();
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
      print("el email ya existe");
    }


  }



  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    // funcion () {
    //   // envie la data a laravel y a su vez a mysql
    // }
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loggeado',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 55,
            backgroundImage: NetworkImage(user.photoURL),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + user.displayName,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + user.email,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            child: Text('Salir'),
          )
        ],
      ),
    );
  }
}
