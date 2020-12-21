import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:http/http.dart' as http;

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
       

      isSigningIn = false;
    }
  }

  void logout() async {
    print("salir");
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  // void enviarLaravel () async{
    
  //   final user = FirebaseAuth.instance.currentUser;

  //   print("------------------------->${user.displayName}===================");

  //   String url = 'http://127.0.0.1:8000/api/logingoogle';

  //   http.Response res = await http.post(
  //     url,
  //     body: {
  //       'name': user.displayName,
  //       'email': user.email,
  //     }
  //   );

  //   print("codigo estado= ${res.statusCode}" );

  // }


}
