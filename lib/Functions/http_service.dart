import 'dart:convert';
import 'dart:developer';
import 'package:domestics/data/UserData.dart';
import 'package:domestics/database/database_helper.dart';
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

Future createAccount(fname, lname, bio, phone, password, email, imageUrl) async {
  var data = {
    "fname": fname,
    "lname": lname,
    "bio": bio,
    "phone": phone,
    "password": password,
    "email": email,
    "imageUrl": imageUrl,
  };

  var encoded = jsonEncode(data);

  var response = await noAuthPostRequest(encoded, '/users');

  if (response.statusCode == 201) {
    final parsed = json.decode(response.body);

    await addUserInfo(
      parsed['user']['_id'],
      parsed['user']['fname'],
      parsed['user']['lname'],
      parsed['user']['isWorker'],
      parsed['user']['bio'],
      parsed['user']['phone'],
      parsed['user']['email'],
      parsed['user']['imageUrl'],
      parsed['token'],
    );

    await populateData(parsed['token']);

    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future populateData(token) async {
  final _dbHelper = DatabaseHelper.instance;
  var response = await getRequest(token, "/users/me");

  log("Population response");
  print(json.decode(response.body));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    var workerTags = parsed['tagsWorker'];
    var clientTags = parsed['tagsClient'];
    var reviews = parsed['reviews'];
    var refferedTo = parsed['refferedTo'];

    log("Deleted tables successfully");

    await _dbHelper.deleteTable("workerTags");
    await _dbHelper.deleteTable("clientTags");
    await _dbHelper.deleteTable("reviews");
    await _dbHelper.deleteTable("refferals");

    if (workerTags.length > 0) {
      for (var i = 0; i < workerTags.length; i++) {
        await addWorkerTag(workerTags[i]['tag'], workerTags[i]['_id']);
      }
    }

    if (clientTags.length > 0) {
      for (var i = 0; i < clientTags.length; i++) {
        await addClientTag(clientTags[i]['tag'], clientTags[i]['_id']);
      }
    }

    if (reviews.length > 0) {
      for (var i = 0; i < reviews.length; i++) {
        await addReview(
          reviews[i]['reviewer_id'],
          reviews[i]['message'],
          reviews[i]['starsCount'],
          reviews[i]['_id'],
        );
      }
    }

    if (refferedTo.length > 0) {
      for (var i = 0; i < refferedTo.length; i++) {
        await addRefferals(refferedTo['reffered'], refferedTo['refferer']);
      }
    }

    log("Populated data successfully");
  } else {
    log("Population request failed");
  }
}

Future login(email, password) async {
  final _dbHelper = DatabaseHelper.instance;
  await _dbHelper.deleteTable("userInfo");
  var data = {"password": password, "email": email};

  var encoded = jsonEncode(data);

  var response = await noAuthPostRequest(encoded, '/users/login');

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);

    await addUserInfo(
      parsed['user']['_id'],
      parsed['user']['fname'],
      parsed['user']['lname'],
      parsed['user']['isWorker'],
      parsed['user']['bio'],
      parsed['user']['phone'],
      parsed['user']['email'],
      parsed['user']['imageUrl'],
      parsed['token'],
    );

    await populateData(parsed['token']);

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
Future uploadClientTags(tags, token) async {
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

Future uploadWorkerTags(tags, token) async {
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
Future uploadReview(userId, message, starsCount, token) async {
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
