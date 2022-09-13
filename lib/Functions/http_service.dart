import 'dart:convert';
import 'package:http/http.dart' as http;

var baseurl = "http://192.168.0.19:3000";

Future createAccount(fname, lname, bio, phone, password, email) async {
  var data = {
    "fname": fname,
    "lname": lname,
    "bio": bio,
    "phone": phone,
    "password": password,
    "email": email
  };

  var encoded = jsonEncode(data);

  print(encoded);

  var response = await http.post(
    Uri.parse('$baseurl/users'),
    body: encoded,
    encoding: Encoding.getByName('utf-8'),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 201) {
    final parsed = json.decode(response.body);
    print(parsed);
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}
