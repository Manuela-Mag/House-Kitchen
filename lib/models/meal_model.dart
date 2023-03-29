class MealModel {
  MealModel({required this.id, required this.name,  required this.image});

  factory MealModel.fromJson(dynamic json) {
    return MealModel(id: json['idMeal'] as String, name: json['strMeal'] as String, image: json['strMealThumb'] as String);
  }

  final String id;
  final String name;
  final String image;
}