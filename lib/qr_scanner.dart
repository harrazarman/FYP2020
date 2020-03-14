import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harraz/add_medical_record.dart';
import 'package:harraz/qr_userInfo.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dashboard.dart';
import 'globals.dart' as globals;

final _formKey = GlobalKey<FormState>();

class QRScanner extends StatefulWidget {
  _QRScanner createState() => _QRScanner();
}

class _QRScanner extends State<QRScanner> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan result: $qrText'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    globals.qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.length != 0) {
        controller.pauseCamera();
        globals.qrUserId = scanData;

        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => QRUserInfo()),
        );
      }else{
        controller.resumeCamera();
      }

      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
