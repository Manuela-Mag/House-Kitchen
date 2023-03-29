import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../models/category_model.dart';
import '../../models/meal_model.dart';
import '../../repos/meal_repo.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc(this._mealRepository) : super(CategoryLoadingState()) {
    on<LoadCategory>((LoadCategory event, Emitter<MealState> emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(CategoryLoadingState());
      emit(MealLoadingState());
      try {
        final List<CategoryModel> categories = await _mealRepository.getListOfCategories();
        emit(CategoryLoadedState(categories, 'Beef'));
        final List<MealModel> meals = await _mealRepository.getListOfMeals('Beef');
        emit(MealLoadedState(meals));
      }
      catch(e) {
        emit(MealLoadingErrorState(e.toString()));
      }
    });
    on<LoadMeal>((LoadMeal event, Emitter<MealState> emit) async {
      emit(MealLoadingState());
      try {
        final List<MealModel> meals = await _mealRepository.getListOfMeals(event.selectedCategoryName);
        emit(MealLoadedState(meals));
      }
      catch(e) {
        emit(MealLoadingErrorState(e.toString()));
      }
    });
  }
  final MealRepository _mealRepository;
}
