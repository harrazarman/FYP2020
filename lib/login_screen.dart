// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:harraz/add_profile.dart';
import 'dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'globals.dart' as globals;

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  final databaseReference = FirebaseDatabase.instance.reference();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _authUser(LoginData data) async {

    if (data.password == '') {
      print('Empty password');
      return null;
    }

    if (data.name == '') {
      print('Empty name');
      return null;
    }

    print(data.password);
    print(data.name);

    FirebaseUser user;
    try {
      user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: data.name, password: data.password))
          .user;
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
        case "ERROR_TOO_MANY_REQUESTS":
          {
            return 'Too many requset. Try again later';
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
    print(data.password);
    print(data.name);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: data.name, password: data.password);
    } catch (error) {
      print(error.code);
    }

    return "Account Created";
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        title: 'Login',
        onLogin: (data) => _authUser(data),
        onSignup: (data) => _register(data),
        onSubmitAnimationCompleted: () {
          _profileChecker(context);
        },
        onRecoverPassword: _recoverPassword);
  }

  Future<void> _profileChecker(BuildContext context) {
    databaseReference
        .child(globals.uid)
        .child('profile')
        .once()
        .then((data) => {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        (data.value == null) ? Add_Profile() : Dashboard()),
              )
            });
    return null;
  }
}
