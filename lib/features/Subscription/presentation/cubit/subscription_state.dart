part of 'subscription_cubit.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SelectIndexContainerState extends SubscriptionState {}
class PlansDataLoadingState extends SubscriptionState {}

class PlansDataSuccessState extends SubscriptionState {}

class PlansDataFailedState extends SubscriptionState {
  final String message;

  PlansDataFailedState({required this.message});
}

