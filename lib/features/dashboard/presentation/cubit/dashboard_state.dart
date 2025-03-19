part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class CategoriesDataLoadingState extends DashboardState {}

class CategoriesDataSuccessState extends DashboardState {}

class CategoriesDataFailedState extends DashboardState {
  final String message;

  CategoriesDataFailedState({required this.message});
}
