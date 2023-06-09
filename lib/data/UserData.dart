import 'dart:math';

import 'package:domestics/database/database_helper.dart';

final dbHelper = DatabaseHelper.instance;

addUserInfo(id, fname, lname, isWorker, bio, phone, email, imageUrl, location,
    token) async {
  Map<String, dynamic> row = {
    "prod_id": id,
    "fname": fname,
    "lname": lname,
    "isWorker": isWorker,
    "bio": bio,
    "phone": phone,
    "email": email,
    "imageUrl": imageUrl,
    "location": location,
    "token": token,
  };

  await dbHelper.insert(row, "userInfo");
  return;
}

addWorkerTag(tag, tagId) async {
  Map<String, dynamic> row = {
    "tag": tag,
    "tag_id": tagId,
  };

  await dbHelper.insert(row, "workerTags");
  return;
}

addClientTag(tag, tagId) async {
  Map<String, dynamic> row = {
    "tag": tag,
    "tag_id": tagId,
  };

  await dbHelper.insert(row, "clientTags");
  return;
}

addWorkers(prodid, fname, lname, bio, phone, imageUrl) async {
  await dbHelper.deleteAll("workers");
  Map<String, dynamic> row = {
    "prod_id": prodid,
    "fname": fname,
    "lname": lname,
    "bio": bio,
    "phone": phone,
    "imageUrl": imageUrl,
  };

  await dbHelper.insert(row, "workers");
  return;
}

addReview(reviewerId, message, starsCount, reviewOwnerId) async {
  Map<String, dynamic> row = {
    "reviewer_id": reviewerId,
    "message": message,
    "stars_count": starsCount,
    "review_owner_id": reviewOwnerId,
  };

  await dbHelper.insert(row, "reviews");
  return;
}

addRefferals(reffered, refferer) async {
  Map<String, dynamic> row = {
    "reffered": reffered,
    "refferer": refferer,
  };

  await dbHelper.insert(row, "refferals");
  return;
}
