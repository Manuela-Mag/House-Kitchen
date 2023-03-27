class CategoryModel {
  final int id;
  final String name;
  final String image;
  final String description;

  CategoryModel({required this.id, required this.name,  required this.image, required this.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['idCategory'], name: json['strCategory'], image: json['strCategoryThumb'], description: json['strCategoryDescription']);
  }
}