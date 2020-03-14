import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harraz/dashboard.dart';

import 'globals.dart' as globals;

class QRUserInfo extends StatefulWidget {
  @override
  _QRUserInfo createState() => _QRUserInfo();
}

class _QRUserInfo extends State<QRUserInfo> {
  final databaseReference = FirebaseDatabase.instance.reference();

  String _name = '';
  String _age = '';
  String _contact = '';
  String _admissionHistory = '';
  String _bloodType = '';
  String _medicalCondition = '';

  Future<void> _loadData(BuildContext context) {
    print('Load Data From Firebase');
    databaseReference
        .child(globals.qrUserId)
        .child('profile')
        .once()
        .then((data) => this.setState(() {
              _name = data.value['name'];
              _age = data.value['age'];
              _contact = data.value['contact'];
            }));

    databaseReference
        .child(globals.qrUserId)
        .child('medical')
        .once()
        .then((data) => this.setState(() {
              _admissionHistory = data.value['admission_history'];
              _bloodType = data.value['blood_type'];
              _medicalCondition = data.value['medical_condition'];
            }));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_name.length == 0) {
      _loadData(context);
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("User Information"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, Dashboard()),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            _card(Icons.person, 'Name', _name),
            _card(Icons.schedule, 'Age', _age),
            _card(Icons.phone, 'Contact', _contact),
            _card(Icons.history, 'Admission History', _admissionHistory),
            _card(Icons.info, 'Blood Type', _bloodType),
            _card(Icons.show_chart, 'Medical Condition',
                _medicalCondition),
          ],
        ),
      ),
    );
  }
}

Widget _card(IconData icon, String label, String text) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(icon, size: 50),
          title: Text(label),
          subtitle: Text(text),
        ),
      ],
    ),
  );
}
