import 'package:mongo_dart/mongo_dart.dart';

class Product {
  // ObjectId? id;
  String? title;
  String? image;
  int? price;
  String? description;

  Product({this.title, this.image, this.price, this.description});

  Product.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
