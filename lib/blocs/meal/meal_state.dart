part of 'meal_bloc.dart';

@immutable
abstract class MealState extends Equatable {}

class MealLoadingState extends MealState {
  @override
  List<Object?> get props => <Object?>[];
}

class MealLoadedState extends MealState {
  MealLoadedState(this.meals);
  final List<MealModel> meals;

  @override
  List<Object?> get props => <Object?>[meals];
}

class MealLoadingErrorState extends MealState {
  MealLoadingErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => <String>[error];
}

class CategoryLoadingState extends MealState {
  @override
  List<Object?> get props => <Object?>[];
}

class CategoryLoadedState extends MealState {
  CategoryLoadedState(this.categories, this.selectedCategory);
  final List<CategoryModel> categories;
  final String selectedCategory;

  @override
  List<Object?> get props => <List<CategoryModel>>[categories];
}

class CategoryLoadingErrorState extends MealState {
  CategoryLoadingErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => <String>[error];
}