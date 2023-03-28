import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../models/category_model.dart';
import '../../repos/meal_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final MealRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryLoadingState()) {
    on<LoadCategory>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        final categories = await _categoryRepository.getListOfCategories();
        emit(CategoryLoadedState(categories, 'beef'));
      }
      catch(e) {
        emit(CategoryLoadingErrorState(e.toString()));
      }
    });
  }
}
