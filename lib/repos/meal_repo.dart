import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitchen_house/models/meal_model.dart';
import '../models/category_model.dart';

class MealRepository {
  String endpoint = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=';
  String endpointCategories = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<MealModel>> getListOfMeals(String categoryName) async {
    final http.Response response = await http.get(Uri.parse(endpoint + categoryName), headers: <String, String>{'Content-Type': 'application/json'});
    if(response.statusCode == 200) {
      final List<dynamic> meals = jsonDecode(response.body)['meals'] as List<dynamic>;
      return meals.map((dynamic e) => MealModel.fromJson(e)).toList();
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<CategoryModel>> getListOfCategories() async {
    final http.Response response = await http.get(Uri.parse(endpointCategories), headers: <String, String>{'Content-Type': 'application/json'});
    if(response.statusCode == 200) {
      final List<dynamic> categories = jsonDecode(response.body)['categories'] as List<dynamic>;
      return categories.map((dynamic e) => CategoryModel.fromJson(e)).toList();
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }
}