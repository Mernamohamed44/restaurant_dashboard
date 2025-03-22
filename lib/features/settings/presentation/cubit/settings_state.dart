part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ChangeNumberState extends SettingsState {}

class AddWordsState extends SettingsState {}

class ClearWordsState extends SettingsState {}

class ChangeStarRatingValueState extends SettingsState {}

class ChooseImageState extends SettingsState {}

class OnColorChangedState extends SettingsState {}
class ContactsLoadingState extends SettingsState {}

class ContactsSuccessState extends SettingsState {}

class ContactsFailState extends SettingsState {
  final String message;

  ContactsFailState({required this.message});
}
class AboutUsLoadingState extends SettingsState {}

class AboutUsSuccessState extends SettingsState {}

class AboutUsFailState extends SettingsState {
  final String message;

  AboutUsFailState({required this.message});
}
class CreateReviewsLoadingState extends SettingsState {}

class CreateReviewsSuccessState extends SettingsState {}

class CreateReviewsFailState extends SettingsState {
  final String message;

  CreateReviewsFailState({required this.message});
}
