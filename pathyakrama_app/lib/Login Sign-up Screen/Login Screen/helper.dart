import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Main Screen/main_screen.dart';
import 'login.dart';

class LoginHelper {

  // handleAuthState()
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const Login();
        }
      }
      );
  }

  // SignInWithGoogle()
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>['email']).signIn();
    if (googleUser == null) return;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the userCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithFacebook() async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    if (res == null) return;

    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(res.accessToken!.token);
    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  //Sign out
  // signOut() {
  //   FirebaseAuth.instance.signOut();
  // }


}
