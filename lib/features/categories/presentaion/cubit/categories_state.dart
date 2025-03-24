part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class ChooseImageState extends CategoriesState {}
class SuperCategoriesDataLoadingState extends CategoriesState {}

class SuperCategoriesDataSuccessState extends CategoriesState {}

class SuperCategoriesDataFailedState extends CategoriesState {
  final String message;

  SuperCategoriesDataFailedState({required this.message});
}

