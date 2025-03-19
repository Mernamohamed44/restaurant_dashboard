import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/Subscription/data/data_source/base_remote_subscription_data_source.dart';
import 'package:restaurant_dashboard/features/Subscription/data/models/plans_model.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';

class RemoteSubscriptionDataSource extends BaseRemoteSubscriptionDataSource {
  final dioManager = DioManager();

  @override
  Future<List<PlansModel>> getPlans() async {
    final Response response = await dioManager
        .get(ApiConstants.plans);
    return List<PlansModel>.from(
        response.data.map((e) => PlansModel.fromJson(e)));
  }


}
