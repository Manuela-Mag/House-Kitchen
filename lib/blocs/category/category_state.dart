part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {}

//loading state
class CategoryLoadingState extends CategoryState {
  @override
  List<Object?> get props => [];
}

//data loaded state
class CategoryLoadedState extends CategoryState {
  CategoryLoadedState(this.categories, this.selectedCategory);
  final List<CategoryModel> categories;
  final String selectedCategory;

  @override
  List<Object?> get props => [categories];
}

//data error loaded state
class CategoryLoadingErrorState extends CategoryState {
  CategoryLoadingErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}