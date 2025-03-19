import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';

abstract class PlansEntities {
  final FeaturesEntities? features;
  final String? description;
  final bool? isActive;
  final String? sId;
  final String? name;
  final  price;
  final int? iV;
  final String? createdAt;
  final String? updatedAt;

  PlansEntities(
      {required this.sId,
      required this.price,
      required this.name,
      required this.description,
      required this.createdAt,
      required this.features,
      required this.isActive,
      required this.updatedAt,
      required this.iV});
}

abstract class FeaturesEntities {
  final bool? aboutUsPage;
  final bool? unlimitedCategories;
  final bool? unlimitedItems;
  final String? dashboardAnalytics;
  final bool? superCategories;
  final bool? visualIdentitySettings;
  final String? themeCustomization;
  final bool? customFonts;
  final bool? customerReviewsPage;
  final bool? contacts;
  final String? localization;
  final bool? offlineMode;
  final bool? themeStoreAccess;
  final bool? customDomain;

  FeaturesEntities(
      {required this.aboutUsPage,
      required this.unlimitedCategories,
      required this.unlimitedItems,
      required this.dashboardAnalytics,
      required this.superCategories,
      required this.visualIdentitySettings,
      required this.themeCustomization,
      required this.customFonts,
      required this.customerReviewsPage,
      required this.contacts,
      required this.localization,
      required this.offlineMode,
      required this.themeStoreAccess,
      required this.customDomain});
}
