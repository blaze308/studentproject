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
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = this.id;
    data['title'] = title;
    data['image'] = image;
    data['price'] = price;
    data['description'] = description;
    return data;
  }
}
