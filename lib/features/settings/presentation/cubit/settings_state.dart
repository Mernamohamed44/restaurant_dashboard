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
