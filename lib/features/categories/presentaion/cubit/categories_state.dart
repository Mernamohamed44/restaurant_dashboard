part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class ChooseImageState extends CategoriesState {}

class UploadImageSuccessState extends CategoriesState {}

class UploadImageFailedState extends CategoriesState {
  final String message;

  UploadImageFailedState({required this.message});
}

class UploadImageLoadingState extends CategoriesState {}

class SuperCategoriesDataLoadingState extends CategoriesState {}

class SuperCategoriesDataSuccessState extends CategoriesState {}

class NoItemSuperCategoriesDataState extends CategoriesState {}

class SuperCategoriesDataFailedState extends CategoriesState {
  final String message;

  SuperCategoriesDataFailedState({required this.message});
}

class CategoriesDataLoadingState extends CategoriesState {}

class CategoriesDataSuccessState extends CategoriesState {}

class CategoriesDataFailedState extends CategoriesState {
  final String message;

  CategoriesDataFailedState({required this.message});
}

class CategoriesDataForMenuLoadingState extends CategoriesState {}

class CategoriesDataForMenuSuccessState extends CategoriesState {}

class CategoriesDataForMenuFailedState extends CategoriesState {
  final String message;

  CategoriesDataForMenuFailedState({required this.message});
}

class AddCategoryLoadingState extends CategoriesState {}

class AddCategorySuccessState extends CategoriesState {}

class AddCategoryFailedState extends CategoriesState {
  final String message;

  AddCategoryFailedState({required this.message});
}

class EditCategoryLoadingState extends CategoriesState {}

class EditCategorySuccessState extends CategoriesState {}

class EditCategoryFailedState extends CategoriesState {
  final String message;

  EditCategoryFailedState({required this.message});
}class DeleteCategoryLoadingState extends CategoriesState {}

class DeleteCategorySuccessState extends CategoriesState {}

class DeleteCategoryFailedState extends CategoriesState {
  final String message;

  DeleteCategoryFailedState({required this.message});
}

class ChangeSelectedIndexState extends CategoriesState {}
