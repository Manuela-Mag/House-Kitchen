class CategoryModel {
  CategoryModel({required this.id, required this.name,  required this.image, required this.description});

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(id: json['idCategory'] as String, name: json['strCategory'] as String, image: json['strCategoryThumb'] as String, description: json['strCategoryDescription'] as String);
  }

  final String id;
  final String name;
  final String image;
  final String description;
}