
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'globals.dart' as globals;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: _content(),
      ),
    );
  }
}

Widget _content() {
  return Container(
    child: Text(globals.uid),
  );
}