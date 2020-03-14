import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harraz/add_profile.dart';
import 'package:harraz/qr_scanner.dart';
import 'package:harraz/userInfo.dart';

import 'globals.dart' as globals;

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final databaseReference = FirebaseDatabase.instance.reference();

  String _name = '';
  String _age = '';
  String _contact = '';
  String _admissionHistory = '';
  String _bloodType = '';
  String _medicalCondition = '';

  void saveToGlobals() {
    print(_name);
    globals.name = _name;
    globals.age = _age;
    globals.contact = _contact;
    globals.admissionHistory = _admissionHistory;
    globals.bloodType = _bloodType;
    globals.medicalCondition = _medicalCondition;
  }

  Future<void> _loadData(BuildContext context) {
    print('Load Data From Firebase');
    databaseReference
        .child(globals.uid)
        .child('profile')
        .once()
        .then((data) => {
              globals.name = data.value['name'],
              globals.age = data.value['age'],
              globals.contact = data.value['contact']
            });

    databaseReference
        .child(globals.uid)
        .child('medical')
        .once()
        .then((data) => {
              globals.admissionHistory = data.value['admission_history'],
              globals.bloodType = data.value['blood_type'],
              globals.medicalCondition = data.value['medical_condition']
            });
    saveToGlobals();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_name == '') {
      _loadData(context);
    }
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text('View Info'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserInfo()),
              ),
            ),
            RaisedButton(
              child: Text('Edit Info'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Add_Profile()),
              ),
            ),
            RaisedButton(
              child: Text('Scan QR'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => QRScanner()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
