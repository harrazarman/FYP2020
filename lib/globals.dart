library app.globals;

import 'package:qr_code_scanner/qr_code_scanner.dart';

bool isLoggedIn = false;

//Profile
String uid = '';
String name = '';
String age = '';
String contact = '';

//Medical
String admissionHistory = '';
String bloodType = '';
String medicalCondition = '';

//QR
QRViewController qrController;
String qrUserId = '';

String toString() {
  return uid + "\n" + name + "\n" + age + "\n" + contact;
}
