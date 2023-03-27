part of 'meal_bloc.dart';

@immutable
abstract class MealEvent extends Equatable {
  const MealEvent();
}

class LoadMeal extends MealEvent {
  @override
  List<Object?> get props => [];
}
