part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class ChangeVisibilityState extends AccountState {}

class ChangeConfirmVisibility extends AccountState {}

class ChangeNumberState extends AccountState {}

class UserDataLoadingState extends AccountState {}

class UserDataSuccessState extends AccountState {}

class UserDataFailState extends AccountState {
  final String message;

  UserDataFailState({required this.message});
}

class CheckUserLoadingState extends AccountState {}

class CheckUserSuccessState extends AccountState {}

class CheckUserFailState extends AccountState {
  final String message;

  CheckUserFailState({required this.message});
}

class ChangePasswordLoadingState extends AccountState {}

class ChangePasswordSuccessState extends AccountState {}

class ChangePasswordFailState extends AccountState {
  final String message;

  ChangePasswordFailState({required this.message});
}
