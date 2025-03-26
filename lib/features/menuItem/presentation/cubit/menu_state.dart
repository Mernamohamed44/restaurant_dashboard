part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}
class ChooseImageState extends MenuState {}
class UploadImageSuccessState extends MenuState {}
class UploadImageFailedState extends MenuState {
  final String message;

  UploadImageFailedState({required this.message});
}
class UploadImageLoadingState extends MenuState {}
class GetItemCategoriesDataLoadingState extends MenuState {}
class LoadingMoreItemCategoriesDataState extends MenuState {}

class GetItemCategoriesDataSuccessState extends MenuState {}
class NoItemCategoriesDataState extends MenuState {}

class GetItemCategoriesDataFailedState extends MenuState {
  final String message;

  GetItemCategoriesDataFailedState({required this.message});
}
class AddItemLoadingState extends MenuState {}

class AddItemSuccessState extends MenuState {}

class AddItemFailState extends MenuState {
  final String message;

  AddItemFailState({required this.message});
}
