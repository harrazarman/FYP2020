import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'globals.dart' as globals;

final _formKey = GlobalKey<FormState>();

class Add_Medical_Record extends StatelessWidget {
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
            _medicalDetails(),
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
                    databaseReference.child(globals.uid).child("medical").set({
                      'admission_history': globals.admissionHistory,
                      'blood_type': globals.bloodType,
                      'medical_condition': globals.medicalCondition
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  }
                },
                child: Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _medicalDetails() {
  return Container(
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Admission History'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              globals.admissionHistory = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Blood Type'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              globals.bloodType = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Medical Condition'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              globals.medicalCondition = value;
            },
          ),
        ],
      ),
    ),
  );
}
