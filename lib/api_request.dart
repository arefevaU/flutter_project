import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

class Categories {
  int cat_id;
  String cat_name;

  Categories(
    {required this.cat_id,
    required this.cat_name}
  );

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      cat_id: json['cat_id'] as int, 
      cat_name: json['cat_name'] as String);
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