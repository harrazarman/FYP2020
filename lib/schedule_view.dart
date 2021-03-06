import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:harraz/add_medical_record.dart';
import 'package:intl/intl.dart';
import 'add_schedule.dart';
import 'dashboard.dart';
import 'globals.dart' as globals;

final _formKey = GlobalKey<FormState>();

class Schedule_View extends StatefulWidget {
  @override
  _Schedule_View createState() => _Schedule_View();
}

class _Schedule_View extends State<Schedule_View> {
  var data = [];

  Future<void> _loadSchedule() {
    FirebaseDatabase.instance
        .reference()
        .child(globals.uid)
        .child("schedule")
        .once()
        .then((rs) {
      for (var _schedule in rs.value.values) {
        data.add(_schedule);
      }
      setState(() {
        
      });
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (data.length == 0) {
      _loadSchedule();
    } else {
      //print(data);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Schedules'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ListView(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Add'),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Add_Schedule()),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Refresh'),
                      onPressed: () => _loadSchedule(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _card(data[index]['day'], data[index]['time'], data[index]['title']);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _card(String day, String time, String title) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(title),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(day),
                  Divider(),
                  Text(time),
                  Divider(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
