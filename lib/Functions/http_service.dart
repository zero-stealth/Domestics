import 'dart:convert';
import 'package:http/http.dart' as http;

var baseurl = "http://localhost:3000";

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
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
    body: data,
    encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 200) {
    // var jsonResponse = convert.jsonDecode();
    final parsed = json.decode(response.body);
    print(parsed);
  } else {
    throw "Unable to create account";
  }
}
