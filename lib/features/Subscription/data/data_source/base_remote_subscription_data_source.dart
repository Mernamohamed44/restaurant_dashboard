import 'package:restaurant_dashboard/features/Subscription/data/models/plans_model.dart';

abstract class BaseRemoteSubscriptionDataSource {
  Future<List<PlansModel>> getPlans();
}
