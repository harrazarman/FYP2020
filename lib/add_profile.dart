import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harraz/add_medical_record.dart';
import 'dashboard.dart';
import 'globals.dart' as globals;

final _formKey = GlobalKey<FormState>();

class Add_Profile extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _userDetails(),
            Spacer(),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (globals.uid == '') {
                      print('UID is empty!');
                      return null;
                    }
                    databaseReference.child(globals.uid).child("profile").set({
                      'name': globals.name,
                      'age': globals.age,
                      'contact': globals.contact
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => Add_Medical_Record()),
                    );
                  }
                },
                child: Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _userDetails() {
  return Container(
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              globals.name = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Age'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              globals.age = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Contact'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              globals.contact = value;
            },
          ),
        ],
      ),
    ),
  );
}
