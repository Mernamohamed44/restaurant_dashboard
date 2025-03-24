part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}
class GetItemCategoriesDataLoadingState extends MenuState {}

class GetItemCategoriesDataSuccessState extends MenuState {}

class GetItemCategoriesDataFailedState extends MenuState {
  final String message;

  GetItemCategoriesDataFailedState({required this.message});
}
