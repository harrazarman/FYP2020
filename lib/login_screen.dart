// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'globals.dart' as globals;


class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  final databaseReference = FirebaseDatabase.instance.reference();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _authUser(LoginData data) async {
    FirebaseUser user;
    try {
      user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: data.name, password: data.password)).user;
      globals.isLoggedIn = true;
      globals.uid = user.uid;
      return null;
    } catch (error) {
      print(error);
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          {
            return 'Email not found';
          }
          break;
        case "ERROR_WRONG_PASSWORD":
          {
            return 'Wrong password';
          }
          break;
        default:
          {
            return '';
          }
      }
    }
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return "Not impliment yet"; // else null
    });
  }

  Future<String> _register(LoginData data) async {
    FirebaseUser user = (await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: data.name, password: data.password)) as FirebaseUser;

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        title: 'Login',
        onLogin: (data) => _authUser(data),
        onSignup: (data) => _register(data),
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
        },
        onRecoverPassword: _recoverPassword);
  }
}
