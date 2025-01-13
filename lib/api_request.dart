import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'main.dart';

class Categories {
  int catId;
  String catName;

  Categories({required this.catId, required this.catName});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
        catId: json['cat_id'] as int, catName: json['cat_name'] as String);
  }
}

Future<List<Categories>> obtainJsonCategories() async {
  var url = Uri.http(apiIP!, 'categories');
  final response = await http.get(url);
  String responseBody = utf8.decode(response.bodyBytes);
  dynamic jsonObject = jsonDecode(responseBody);
  final converterJsonObject = jsonObject.cast<Map<String, dynamic>>();
  List<Categories> list = converterJsonObject
      .map<Categories>((json) => Categories.fromJson(json))
      .toList();
  // list.forEach((element) {
  //   print(element.cat_name);
  //   print(element.cat_id);
  // });
  return list;
}

class Products {
  int prodId, catId, categoryId;
  String prodName, description, photoPath, catName;
  double price, gram;

  Products(
      {required this.prodId,
      required this.catId,
      required this.categoryId,
      required this.prodName,
      required this.description,
      required this.photoPath,
      required this.catName,
      required this.price,
      required this.gram});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        prodId: json['prod_id'] as int,
        catId: json['category_id'] as int,
        categoryId: json['cat_id'] as int,
        prodName: json['prod_name'] as String,
        description: json['description'] as String,
        photoPath: json['photo_path'] as String,
        catName: json['cat_name'] as String,
        price: json['price'] as double,
        gram: json['gram'] as double);
  }
}

Future<List<Products>> obtainJsonProducts() async {
  var url = Uri.http(apiIP!, 'products');
  final response = await http.get(url);
  String responseBody = utf8.decode(response.bodyBytes);
  dynamic jsonObject = jsonDecode(responseBody);
  final converterJsonObject = jsonObject.cast<Map<String, dynamic>>();
  List<Products> list = converterJsonObject
      .map<Products>((json) => Products.fromJson(json))
      .toList();
  // list.forEach((element) {
  //   print(element.prodName);
  //   print(element.price);
  //   print(element.photoPath);
  // });
  return list;
}

class Favourites {
  int favId, userId, prodId;

  Favourites({
    required this.favId,
    required this.userId,
    required this.prodId,
  });

  factory Favourites.fromJson(Map<String, dynamic> json) {
    return Favourites(
        favId: json['fav_id'] as int,
        userId: json['user_id'] as int,
        prodId: json['product_id'] as int);
  }
}

Future<List<Favourites>> obtainJsonFavourites() async {
  var url = Uri.http(apiIP!, 'favourite', {'user_id': id.toString()});
  final response = await http.get(url);
  String responseBody = utf8.decode(response.bodyBytes);
  dynamic jsonObject = jsonDecode(responseBody);
  final converterJsonObject = jsonObject.cast<Map<String, dynamic>>();
  List<Favourites> list = converterJsonObject
      .map<Favourites>((json) => Favourites.fromJson(json))
      .toList();
  return list;
}

class Basket {
  int basketId, userId, prodId;

  Basket({
    required this.basketId, 
    required this.userId, 
    required this.prodId
  });

  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      basketId: json['bask_id'] as int, 
      userId: json['user_id'] as int, 
      prodId: json['prod_id'] as int);
  }
}

Future<List<Basket>> obtainJsonBasket() async {
  var url = Uri.http(apiIP!, 'basket', {'user_id': id.toString()});
  final response = await http.get(url);
  String responseBody = utf8.decode(response.bodyBytes);
  dynamic jsonObject = jsonDecode(responseBody);
  final converterJsonObject = jsonObject.cast<Map<String, dynamic>>();
  List<Basket> list = converterJsonObject.map<Basket>((json) => Basket.fromJson(json)).toList();
  return list;
}

