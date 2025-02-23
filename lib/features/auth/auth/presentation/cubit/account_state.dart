part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class ChangeVisibilityState extends AccountState {}

class ChangeConfirmVisibility extends AccountState {}

class ChangeNumberState extends AccountState {}
