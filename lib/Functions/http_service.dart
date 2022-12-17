import 'dart:convert';
import 'dart:developer';
import 'package:domestics/Functions/requests.dart';
import 'package:domestics/data/UserData.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/models/tags_model.dart';
import 'package:domestics/models/worker_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:ui';

import '../controllers/user_controller.dart';
import '../controllers/workers_controller.dart';

var baseurl = "http://192.168.0.22:3000";

Future createAccount(
    fname, lname, bio, phone, password, email, imageUrl) async {
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
  final _controller = Get.put(UserController());
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

    await _dbHelper.deleteTable("userInfo");
    await _dbHelper.deleteTable("workerTags");
    await _dbHelper.deleteTable("clientTags");
    await _dbHelper.deleteTable("reviews");
    await _dbHelper.deleteTable("refferals");

    log("Deleted tables successfully");

    await addUserInfo(
      parsed['_id'],
      parsed['fname'],
      parsed['lname'],
      parsed['isWorker'],
      parsed['bio'],
      parsed['phone'],
      parsed['email'],
      parsed['imageUrl'],
      token,
    );

    _controller.addUser({
      "prod_id": parsed['_id'],
      "fname": parsed['fname'],
      "lname": parsed['lname'],
      "bio": parsed['bio'],
      "isWorker": parsed['isWorker'],
      "phone": parsed['phone'],
      "email": parsed['email'],
      "imageUrl": parsed['imageUrl'],
      "token": token,
    });

    log("Added user info");

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

Future checkphone(phone, token) async {
  var data = {"phone": phone};

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/users/checkphone');

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

  if (response.statusCode == 201) {
    await populateData(token);
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

  if (response.statusCode == 201) {
    await populateData(token);
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

// userId is the ID of the user
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

Future updateUserInfo(data, token) async {
  var encoded = jsonEncode(data);

  var response = await patchRequest(encoded, token, "/users/me");

  if (response.statusCode == 200) {
    await populateData(token);
    return true;
  } else {
    return false;
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

Future uploadFeedback(token, message) async {
  var data = {"message": message};

  var encoded = jsonEncode(data);

  var response = await postRequest(encoded, token, '/feedback');

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
    // throw "Unable to create account";
  }
}

Future _getToken() async {
  final dbHelper = DatabaseHelper.instance;
  var user = await dbHelper.queryAllRows("userInfo");
  return user[0]["token"];
}

Future getWorkerById(id) async {
  var token = await _getToken();
  var res = await getRequest(token, "/users/worker?workerid=$id");
  if (res.statusCode == 200) {
    final parsed = json.decode(res.body);
    return "${parsed[0]['fname']} ${parsed[0]['lname']}";
  } else {
    return "Deleted";
  }
}

Future getWorkers() async {
  final controller = Get.put(WorkersController());
  controller.deleteWorkers();
  var token = await _getToken();
  var res = await getRequest(token, "/users/workers");
  if (res.statusCode == 200) {
    final parsed = json.decode(res.body);
    log("WORKERS $parsed");
    for (var i = 0; i < parsed.length; i++) {
      await addWorkers(
        parsed[i]["_id"],
        parsed[i]["fname"],
        parsed[i]["lname"],
        parsed[i]["bio"],
        parsed[i]["phone"],
        parsed[i]["imageUrl"],
      );

      int starsCount = 0;

      if (parsed[i]['reviews'].length > 0) {
        for (var n = 0; n < parsed[i]['reviews'].length; n++) {
          log("RAN $n");
          starsCount =
              starsCount + int.parse(parsed[i]['reviews'][n]['starsCount']);
        }

        for (var r = 0; r < parsed[i]['reviews'].length; r++) {
          parsed[i]['reviews'][r]['username'] =
              await getWorkerById(parsed[i]['reviews'][r]["reviewer_id"]);
        }
      }

      controller.addWorker({
        "prod_id": parsed[i]['_id'],
        "fname": parsed[i]['fname'],
        "lname": parsed[i]['lname'],
        "bio": parsed[i]['bio'],
        "phone": parsed[i]['phone'],
        "imageUrl": parsed[i]['imageUrl'],
        "tags": parsed[i]['tagsWorker'],
        "location": parsed[i]['location'],
        "starsCount": starsCount == 0
            ? starsCount.toDouble()
            : starsCount / parsed[i]['reviews'].length,
        "reviews": parsed[i]['reviews'],
      });
    }
    return;
  } else {
    return;
  }
}

Future getAllTags() async {
  var token = await _getToken();
  final dbHelper = DatabaseHelper.instance;
  var res = await dbHelper.queryAllRows("workers");
  var tags = [];

  for (var i = 0; i < res.length; i++) {
    var workerInfo =
        await getRequest(token, "/users/worker?workerid=${res[i]['prod_id']}");
    final parsed = json.decode(workerInfo.body);
    tags.add({
      "userid": parsed[0]["_id"],
      "tags": parsed[0]['tagsWorker'],
    });

    // var data =
    //     TagsModel(userid: parsed[0]['_id'], tags: parsed[0]['tagsWorker']);

    // context.read<WorkerProvider>().addTags(data);
  }

  return tags;
}
