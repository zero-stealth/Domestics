import 'dart:convert';

import 'package:http/http.dart' as http;

var baseurl = "http://192.168.0.19:3000";

Future postRequest(encoded, token, route) async {
  var response = await http.post(
    Uri.parse('$baseurl$route'),
    body: encoded,
    encoding: Encoding.getByName('utf-8'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  return response;
}

Future patchRequest(encoded, token, route) async {
  var response = await http.patch(
    Uri.parse('$baseurl$route'),
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
    Uri.parse('$baseurl$route'),
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
    Uri.parse('$baseurl$route'),
    body: encoded,
    encoding: Encoding.getByName('utf-8'),
    headers: {"Content-Type": "application/json"},
  );

  return response;
}