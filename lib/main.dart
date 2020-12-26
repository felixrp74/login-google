
// =========================GOOGLE 
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:login_google/vista/inicio_vista.dart';
 
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {

  static final String title = 'LOGIN';

  @override
  Widget build(BuildContext context) => 
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: title,        
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: InicioVista(),
        // home: LoginGoogle(),
    );

}


class LoginGoogle extends StatefulWidget {
  @override
  _LoginGoogleState createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {

  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(_googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,),
                  Text(_googleSignIn.currentUser.displayName),
                  Text(_googleSignIn.currentUser.email),
                  // Spacer(),
                  OutlineButton( child: Text("Salir"), onPressed: (){
                      _logout();
                    },
                  )
                ],
              )
            : Center(
                child: OutlineButton(
                  child: Text("Google"),
                  onPressed: () {
                    _login();
                  },
                ),
              )
            ),
      ),
    );
  }
}
























