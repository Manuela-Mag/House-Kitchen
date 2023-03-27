import 'dart:convert';
import 'package:http/http.dart';
import 'package:kitchen_house/models/category_model.dart';

class CategoryRepository {
  String endpoint = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<CategoryModel>> getListOfCategories() async {
    Response response = await get(Uri.parse(endpoint), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200) {
      final List categories = jsonDecode(response.body)['categories'];
      return categories.map(((e) => CategoryModel.fromJson(e))).toList();
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }
}