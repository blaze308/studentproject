// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:studentproject/db/constant.dart';
import 'package:studentproject/db/product_model.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(mongoConnectionUrl);
    await db.open();
    inspect(db);
    userCollection = db.collection(mongoUserCollection);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final data = await userCollection.find().toList();
    return data;
  }

  static Future<String> insert(Product data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "data inserted";
      } else {
        return "something went wrong";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
