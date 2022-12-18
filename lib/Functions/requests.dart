import 'dart:convert';
import 'dart:io';

import 'package:domestics/Functions/Utility.dart';
import 'package:http/http.dart' as http;

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

Future uploadImageRequest(filepath, token) async {
  var request =
      http.MultipartRequest('POST', Uri.parse('$baseUrl/users/profileImage'));
  request.files.add(await http.MultipartFile.fromPath('image', filepath));
  request.headers.addAll(
    {"Content-Type": "application/json", "Authorization": "Bearer $token"},
  );
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
