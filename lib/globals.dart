library app.globals;


bool isLoggedIn = false;

String uid = '';
String name = '';
String age = '';
String contact = '';

String toString() {
  return uid + "\n" + name + "\n" + age + "\n" + contact;
}
