// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dashboard.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  final databaseReference = FirebaseDatabase.instance.reference();
  var uuid = Uuid();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {}

  Future<String> _authUser(LoginData data) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: data.name, password: data.password)).user;
      return null;
    } catch (error) {
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
      if (!users.containsKey(name)) {
        print('Username not exists');
        return 'Username not exists';
      }
      return null;
    });
  }

  Future<String> _register(LoginData data) async {
    // databaseReference
    //     .child("account")
    //     .child(uuid.v4())
    //     .set({'email': data.name, 'password': data.password});

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
