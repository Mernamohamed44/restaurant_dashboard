import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/items_model.dart';

abstract class BaseRemoteSettingsDataSource {
  Future<void> createContacts({
    required List phones,
    required List emails,
    required List addresses,
    required List<Map> socialMedia,
});
}
