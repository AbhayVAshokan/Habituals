import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth change user stream
  Stream<FirebaseUser> get userStream {
    return _auth.onAuthStateChanged;
  }

  // Register with email and password
  Future<FirebaseUser> registerWithEmailAndPassword(
      {String email, String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      if (e.toString().contains('ERROR_NETWORK_REQUEST_FAILED'))
        Fluttertoast.showToast(
          msg: "Network error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      else if (e.toString().contains('ERROR_EMAIL_ALREADY_IN_USE'))
        Fluttertoast.showToast(
          msg: "Email already registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      else
        print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future<FirebaseUser> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      if (e.toString().contains('ERROR_USER_NOT_FOUND'))
        Fluttertoast.showToast(
          msg: "User not registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      else if (e.toString().contains('ERROR_NETWORK_REQUEST_FAILED'))
        Fluttertoast.showToast(
          msg: "Network error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      else if (e.toString().contains('ERROR_WRONG_PASSWORD'))
        Fluttertoast.showToast(
          msg: "Wrong password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      else
        print(e.toString());

      return null;
    }
  }

  // Sign out
  Future logOut({@required FirebaseUser user}) async {
    try {
      if (user.isAnonymous)
        user.delete();
      else {
        await _auth.signOut();
      }
    } catch (e) {
      if (e.toString().contains('ERROR_NETWORK_REQUEST_FAILED'))
        Fluttertoast.showToast(
          msg: "Network error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      else
        print(e.toString());
      return null;
    }
  }

  // Forgot password
  Future resetPassword({@required String email}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (e.toString().contains('\'email != null\': is not true'))
        Fluttertoast.showToast(
          msg: "Enter valid email address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      else
        Fluttertoast.showToast(
          msg: "Password reset link sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
    }
  }
}
