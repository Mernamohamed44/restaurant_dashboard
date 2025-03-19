import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_dashboard/features/Subscription/domain/entities/plans_entities.dart';
import 'package:restaurant_dashboard/features/Subscription/domain/repository/base_subscription_repository.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit(this.repo) : super(SubscriptionInitial());
  int selectedIndex = 0;
  final BaseSubscriptionRepository repo;
  selectIndexContainer(index) {
    selectedIndex = index;
    emit(SelectIndexContainerState());
  }

  List<PlansEntities> plans = [];

  Future getPlans() async {
    emit(PlansDataLoadingState());
    final response = await repo.getPlans();
    response.fold(
      (l) {
        emit(PlansDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        plans = r;
        emit(PlansDataSuccessState());
      },
    );
  }
}
