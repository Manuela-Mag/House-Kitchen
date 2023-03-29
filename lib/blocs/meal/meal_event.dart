part of 'meal_bloc.dart';

@immutable
abstract class MealEvent extends Equatable {
  const MealEvent();
}

class LoadCategory extends MealEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class LoadMeal extends MealEvent {
  const LoadMeal(this.selectedCategoryName);
  final String selectedCategoryName;

  @override
  List<Object?> get props => <String>[selectedCategoryName];
}

