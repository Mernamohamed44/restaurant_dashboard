import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial());
  int selectedIndex = 0;

  selectIndexContainer(index) {
    selectedIndex = index;
    emit(SelectIndexContainerState());
  }
}
