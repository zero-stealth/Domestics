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

Future noAuthPostRequest(encoded, route) async {
  var response = await http.post(
    Uri.parse('$baseurl$route'),
    body: encoded,
    encoding: Encoding.getByName('utf-8'),
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

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

  var response = await noAuthPostRequest(encoded, '/users');

  if (response.statusCode == 201) {
    final parsed = json.decode(response.body);
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future login(email, password, token) async {
  var data = {"password": password, "email": email};

  var encoded = jsonEncode(data);

  var response = await noAuthPostRequest(encoded, '/users/login');

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);

    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future checkusername(fname, lname) async {
  var data = {"fname": fname, "lname": lname};

  var encoded = jsonEncode(data);

  var response = await noAuthPostRequest(encoded, '/users/checkusername');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future checkemail(email) async {
  var data = {"email": email};

  var encoded = jsonEncode(data);

  var response = await noAuthPostRequest(encoded, '/users/checkemail');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

// tags should be an array
Future addClientTags(tags, token) async {
  var data = {"tags": tags};

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/addClientTags');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future addWorkerTags(tags, token) async {
  var data = {"tags": tags};

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/addWorkerTags');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future deleteClientTags(tagId, token) async {
  var data = {"tag_id": tagId};

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/clientTag/delete');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future deleteWorkerTags(tagId, token) async {
  var data = {"tag_id": tagId};

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/workerTag/delete');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

// userId is the ID of the
// being reviewed
Future addReview(userId, message, starsCount, token) async {
  var data = {
    "id": userId,
    "review": {
      "message": message,
      "starsCount": starsCount,
    }
  };

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/users/review');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future deleteReview(reviewId, reviewedUserId, token) async {
  var data = {
    "review_id": reviewId,
    "reviewed_user_id": reviewedUserId,
  };

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/reviews/delete');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future refferWorker(reffererId, refferedId, token) async {
  var data = {
    "id": refferedId,
    "reffered": refferedId,
  };

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/refferWorker');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future logout(token) async {
  var data = {};

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/users/logout');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future logoutAll(token) async {
  var data = {};

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/users/logoutAll');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}
