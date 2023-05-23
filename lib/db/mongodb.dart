import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:studentproject/db/constant.dart';

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
}
