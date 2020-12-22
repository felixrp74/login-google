// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// // import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// class LoginFacebook extends StatefulWidget {
//   @override
//   _LoginFacebookState createState() => _LoginFacebookState();
// }

// class _LoginFacebookState extends State<LoginFacebook> {
//   bool isSignIn = false;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   User _user;
//   FacebookLogin facebookLogin = FacebookLogin();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("FB"),
//       ),
//       body: isSignIn
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   CircleAvatar(
//                     radius: 80,
//                     backgroundImage: NetworkImage(_user.photoURL),
//                   ),
//                   Text(
//                     _user.displayName,
//                     style: TextStyle(fontSize: 30),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   OutlineButton(
//                     onPressed: () {
//                       gooleSignout();
//                     },
//                     child: Text(
//                       "Logout",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           : Center(
//               child: OutlineButton(
//                 onPressed: () async {
//                   await handleLogin();
//                 },
//                 child: Text(
//                   "FACEBOOK",
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//             ),
//     );
//   }

  // Future<void> handleLogin() async {
    // final facebookLogin = FacebookLogin();
    // final result = await facebookLogin.logIn(['email']);
    // facebookLogin.lo

    // print('========${result.status}=======');
    // switch (result.status) {
      // case FacebookLoginStatus.loggedIn:
      //   _sendTokenToServer(result.accessToken.token);
      //   _showLoggedInUI();
      //   break;
      // case FacebookLoginStatus.cancelledByUser:
      //   _showCancelledMessage();
      //   break;
      // case FacebookLoginStatus.error:
      //   _showErrorOnUI(result.errorMessage);
      //   break;
    // }










    // final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    
    
    // print('======================${result.status}===================');
    // switch (result.status) {
    //   case FacebookLoginStatus.cancelledByUser:
    //     break;
    //   case FacebookLoginStatus.error:
    //     break;
    //   case FacebookLoginStatus.loggedIn:
    //     try {
    //       await loginWithfacebook(result);
    //     } catch (e) {
    //       print(e);
    //     }
    //     break;
    // }


  // }

//   Future loginWithfacebook(FacebookLoginResult result) async {
//     final FacebookAccessToken accessToken = result.accessToken;
//     AuthCredential credential =
//         FacebookAuthProvider.credential(accessToken.token);
//     var a = await _auth.signInWithCredential(credential);
//     setState(() {
//       isSignIn = true;
//       _user = a.user;
//     });
//   }

//   Future<void> gooleSignout() async {
//     await _auth.signOut().then((onValue) {
//       setState(() {
//         facebookLogin.logOut();
//         isSignIn = false;
//       });
//     });
//   }
// }


/*

Scotiabank SOLES: 706-0481715
BCP SOLES: 49596310018024
YAPE: 934108741

886310988781646

*/
















