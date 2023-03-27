part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class LoadCategory extends CategoryEvent {
  @override
  List<Object?> get props => [];
}
