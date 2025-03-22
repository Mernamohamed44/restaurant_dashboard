import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/items_model.dart';

abstract class BaseRemoteSettingsDataSource {
  Future<void> createContacts({
    required List phones,
    required List emails,
    required List addresses,
    required List<Map> socialMedia,
});Future<void> createAboutUs({
    required String name,
    required String title,
    required String description,
    required List tags,
});Future<void> createReviews({
    required String user,
    required String starRatingEnabled,
    required String generalCommentEnabled,
    required String customerNameRequired,
    required String customerEmailRequired,
    required String thankYouMessage,
    required List<Map> customInputs,
});
}
