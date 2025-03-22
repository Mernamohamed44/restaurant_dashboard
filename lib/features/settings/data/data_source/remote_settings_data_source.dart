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

  @override
  Future<void> createAboutUs(
      {required String name,
      required String title,
      required String description,
      required List tags}) async {
    await dioManager.post(
      ApiConstants.aboutUs,
      data: {
        "name": name,
        "title": title,
        "description": description,
        "tags": tags,
      },
    );
  }

  @override
  Future<void> createReviews(
      {required String user,
      required String starRatingEnabled,
      required String generalCommentEnabled,
      required String customerNameRequired,
      required String customerEmailRequired,
      required String thankYouMessage,
      required List<Map> customInputs}) async {
    await dioManager.post(
      ApiConstants.aboutUs,
      data: {
        "user": user,
        "starRatingEnabled": starRatingEnabled,
        "generalCommentEnabled": generalCommentEnabled,
        "customerNameRequired": customerNameRequired,
        "customerEmailRequired": customerEmailRequired,
        "thankYouMessage": thankYouMessage,
        "customInputs": customInputs,
      },
    );
  }
}
