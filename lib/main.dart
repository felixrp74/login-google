// import 'package:flutter/material.dart';
// import 'package:login_google/page/home_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   static final String title = 'GOO';

//   @override
//   Widget build(BuildContext context) => 
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//         title: title,        
//         theme: ThemeData(primarySwatch: Colors.deepOrange),
//         home: HomePage(),
//     );


//     // MaterialApp(
//     //     debugShowCheckedModeBanner: false,
//     //     title: title,        
//     //     theme: ThemeData(primarySwatch: Colors.deepOrange),
//     //     home: HomePage(),
//     //   );
// }
 

















// import 'package:flutter/material.dart';
// import 'package:login_google/page/login_facebook.dart'; 
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FACEBOOK',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: LoginFacebook(),
//       // home: Kaka(),
//     );
//   }
// }
 
/*
ESTRICATAMENTE EN GITBASH
vGUNyNGTYOBcyFKikRugd5m3rmI=
vGUNyNGTYOBcyFKikRugd5m3rmI=


*/


















// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MaterialApp(
//     home: MyApp(),
//   ));
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   static final FacebookLogin facebookSignIn = new FacebookLogin();
//   String name = '', image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('title'),
//         actions: [
//           FlatButton(
//             child: Text(
//               'FACEBOOK',
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () async {
//               final FacebookLoginResult result =
//                   await facebookSignIn.logIn(['email']);

//                   print('===============${result.status}================');

//               switch (result.status) {
//                 case FacebookLoginStatus.loggedIn:
//                   final FacebookAccessToken accessToken = result.accessToken;
//                   final graphResponse = await http.get(
//                       'https://graph.facebook.com/v2.12/me?fields=first_name,picture&access_token=${accessToken.token}');
//                   final profile = jsonDecode(graphResponse.body);
//                   print(profile);
//                   setState(() {
//                     name = profile['first_name'];
//                     image = profile['picture']['data']['url'];
//                   });
//                   print('''
//                     Logged in!
                    
//                     Token: ${accessToken.token}
//                     User id: ${accessToken.userId}
//                     Expires: ${accessToken.expires}
//                     Permissions: ${accessToken.permissions}
//                     Declined permissions: ${accessToken.declinedPermissions}
//                    ''');
//                   break;
//                 case FacebookLoginStatus.cancelledByUser:
//                   print('Login cancelled by the user.');
//                   break;
//                 case FacebookLoginStatus.error:
//                   print('Something went wrong with the login process.\n'
//                       'Here\'s the error Facebook gave us: ${result.errorMessage}');
//                   break;
//               }
//             },
//           )
//         ],
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(name),
//           image != null
//               ? Container(
//                   height: 200,
//                   width: 200,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(image: NetworkImage(image)),
//                       shape: BoxShape.circle),
//                 )
//               : Container()
//         ],
//       )),
//     );
//   }
// }





















import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(MyApp());
}

String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> _userData;
  AccessToken _accessToken;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkIfIsLogged();
  }

  Future<void> _checkIfIsLogged() async {
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken.toJson()),
    );
  }

  Future<void> _login() async {
    try {
      // show a circular progress indicator
      setState(() {
        _checking = true;
      });
      _accessToken = await FacebookAuth.instance.login(); // by the fault we request the email and the public profile
      // loginBehavior is only supported for Android devices, for ios it will be ignored
      // _accessToken = await FacebookAuth.instance.login(
      //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
      //   loginBehavior:
      //       LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
      // );
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
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
      setState(() {
        _checking = false;
      });
    }
  }


  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Facebook Auth Example'),
        ),
        body: _checking
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _userData != null ? prettyPrint(_userData) : "NO LOGGED",
                      ),
                      SizedBox(height: 20),
                      _accessToken != null
                          ? Text(
                              prettyPrint(_accessToken.toJson()),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      CupertinoButton(
                        color: Colors.blue,
                        child: Text(
                          _userData != null ? "LOGOUT" : "INICIAR",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _userData != null ? _logOut : _login,
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}


// felix@gruposistemas.com 
// yordi18122020