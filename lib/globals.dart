library app.globals;

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

String toString() {
  return uid + "\n" + name + "\n" + age + "\n" + contact;
}
