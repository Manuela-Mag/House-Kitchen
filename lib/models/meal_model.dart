class MealModel {
  final String id;
  final String name;
  final String image;

  MealModel({required this.id, required this.name,  required this.image});

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(id: json['idMeal'], name: json['strMeal'], image: json['strMealThumb']);
  }
}