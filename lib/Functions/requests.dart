import 'dart:convert';
import 'dart:io';

import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:http/http.dart' as http;

Future _getToken() async {
  final dbHelper = DatabaseHelper.instance;
  var user = await dbHelper.queryAllRows("userInfo");
  return user[0]["token"];
}

Future postRequest(encoded, token, route) async {
  var response = await http.post(
    Uri.parse('$baseUrl$route'),
    body: encoded,
    encoding: Encoding.getByName('utf-8'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  return response;
}

Future uploadImageRequest(filepath) async {
  var token = await _getToken();
  var request =
      http.MultipartRequest('POST', Uri.parse('$baseUrl/users/profileImage'));
  request.headers.addAll(
    {"Authorization": "Bearer $token"},
  );
  request.files.add(await http.MultipartFile.fromPath('image', filepath));
  var res = await request.send();
  print(res.reasonPhrase);
  return true;
}

Future patchRequest(encoded, token, route) async {
  var response = await http.patch(
    Uri.parse('$baseUrl$route'),
    body: encoded,
    encoding: Encoding.getByName('utf-8'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  return response;
}

Future getRequest(token, route) async {
  var response = await http.get(
    Uri.parse('$baseUrl$route'),
    //encoding: Encoding.getByName('utf-8'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  return response;
}

Future noAuthPostRequest(encoded, route) async {
  var response = await http.post(
    Uri.parse('$baseUrl$route'),
    body: encoded,
    encoding: Encoding.getByName('utf-8'),
    headers: {"Content-Type": "application/json"},
  );

  return response;
}
