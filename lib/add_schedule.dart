import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:harraz/add_medical_record.dart';
import 'package:harraz/schedule_view.dart';
import 'package:intl/intl.dart';
import 'dashboard.dart';
import 'globals.dart' as globals;

final _formKey = GlobalKey<FormState>();

class Add_Schedule extends StatefulWidget {
  @override
  _Add_Schedule createState() => _Add_Schedule();
}

class _Add_Schedule extends State<Add_Schedule> {
  final databaseReference = FirebaseDatabase.instance.reference();
  String day = 'Monday';
  String time = '00:00';
  String title = 'No title';

  Future<void> _addSchedule() {
    if (globals.uid == '') {
      print('UID is empty!');
      return null;
    }

    databaseReference
        .child(globals.uid)
        .child("schedule")
        .child(day)
        .update({
          'title': title,
          'time': time
        });

    Navigator.of(context).pop(
      MaterialPageRoute(builder: (context) => Schedule_View()),
    );

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Schedules'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            _card2(),
            _card(),
            Container(
              height: 30,
            ),
            Container(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  _addSchedule();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dateTimeChooser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        DropdownButton<String>(
          value: day,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          items: <String>[
            'Sunday',
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday'
          ].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          onChanged: (String newValue) {
            setState(
              () {
                day = newValue;
              },
            );
          },
        ),
        Container(
          child: RaisedButton(
            onPressed: () {
              DatePicker.showTimePicker(
                context,
                showTitleActions: true,
                onConfirm: (dt) {
                  print(dt);
                  setState(
                    () {
                      time = new DateFormat.Hm().format(dt).toString();
                    },
                  );
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
            },
            child: Text(
              time,
            ),
          ),
        ),
      ],
    );
  }

  Widget _card() {
    return Container(
      width: double.infinity,
      child: Card(
        child: Container(
          margin: EdgeInsets.all(30),
          child: _dateTimeChooser(),
        ),
      ),
    );
  }

    Widget _card2() {
    return Container(
      width: double.infinity,
      child: Card(
        child: Container(
          margin: EdgeInsets.all(30),
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              title = value;
            },
          ),
        ),
      ),
    );
  }
}
