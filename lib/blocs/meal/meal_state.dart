part of 'meal_bloc.dart';

@immutable
abstract class MealState extends Equatable {}

//loading state
class MealLoadingState extends MealState {
  @override
  List<Object?> get props => [];
}

//data loaded state
class MealLoadedState extends MealState {
  MealLoadedState(this.meals);
  final List<MealModel> meals;

  @override
  List<Object?> get props => [meals];
}

//data error loaded state
class MealLoadingErrorState extends MealState {
  MealLoadingErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}