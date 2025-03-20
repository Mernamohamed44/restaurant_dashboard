import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/dashboard/data/data_source/base_remote_dashboard_data_source.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/items_model.dart';
import 'package:restaurant_dashboard/features/settings/data/data_source/base_remote_settings_data_source.dart';

class RemoteSettingsDataSource extends BaseRemoteSettingsDataSource {
  final dioManager = DioManager();

  @override
  Future<void> createContacts(
      {required List phones,
      required List emails,
      required List addresses,
      required List<Map> socialMedia}) async {
    await dioManager.post(
      ApiConstants.contacts,
      data: {
        "phones": phones,
        "emails": emails,
        "addresses": addresses,
        "socialMedia": socialMedia,
      },
    );
  }
}
