import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harraz/dashboard.dart';

import 'globals.dart' as globals;

class UserInfo extends StatefulWidget {
  @override
  _UserInfo createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
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
              _card(Icons.person, 'Name', globals.name),
              _card(Icons.schedule, 'Age', globals.age),
              _card(Icons.phone, 'Contact', globals.contact),
              _card(
                  Icons.history, 'Admission History', globals.admissionHistory),
              _card(Icons.info, 'Blood Type', globals.bloodType),
              _card(Icons.show_chart, 'Medical Condition',
                  globals.medicalCondition),
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
