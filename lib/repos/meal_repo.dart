import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitchen_house/models/meal_model.dart';

import '../models/category_model.dart';

class MealRepository {
  String endpoint = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=';
  String endpointCategories = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<MealModel>> getListOfMeals(String categoryName) async {
    http.Response response = await http.get(Uri.parse(endpoint + categoryName), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200) {
      final List meals = jsonDecode(response.body)['meals'];
      return meals.map(((e) => MealModel.fromJson(e))).toList();
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<CategoryModel>> getListOfCategories() async {
    http.Response response = await http.get(Uri.parse(endpointCategories), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200) {
      final List categories = jsonDecode(response.body)['categories'];
      return categories.map(((e) => CategoryModel.fromJson(e))).toList();
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }
}