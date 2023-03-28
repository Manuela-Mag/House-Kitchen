import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../models/meal_model.dart';
import '../../repos/meal_repo.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository _mealRepository;

  MealBloc(this._mealRepository) : super(MealLoadingState()) {
    on<LoadMeal>((event, emit) async {
      emit(MealLoadingState());
      try {
        final meals = await _mealRepository.getListOfMeals();
        emit(MealLoadedState(meals));
      }
      catch(e) {
        emit(MealLoadingErrorState(e.toString()));
      }
    });
  }
}
