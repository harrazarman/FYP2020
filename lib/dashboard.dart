import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Future<void> _loadData(BuildContext context) {
    databaseReference
        .child(globals.uid)
        .child('profile')
        .once()
        .then((data) => {
              setState(() => {
                    _name = data.value['name'],
                    _age = data.value['age'],
                    _contact = data.value['contact']
                  })
            });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_name == '') {
      _loadData(context);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Card(
                child: Column(
                  children: <Widget>[
                    Text("Name $_name"),
                    Text("Age $_age"),
                    Text("Contact $_contact"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
