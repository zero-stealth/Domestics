import 'dart:convert';
import 'package:http/http.dart' as http;

var baseurl = "http://192.168.0.25:3000";

Future createAccount(fname, lname, bio, phone, password, email) async {
  var data = {
    "fname": fname,
    "lname": lname,
    "bio": bio,
    "phone": phone,
    "password": password,
    "email": email
  };
  var response = await http.Client().post(Uri.parse('$baseurl/users'), 
    body: jsonEncode(data),
    encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    print(parsed);
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}
