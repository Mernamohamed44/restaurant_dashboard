import 'package:restaurant_dashboard/features/Subscription/domain/entities/plans_entities.dart';

class PlansModel extends PlansEntities {
  PlansModel({
    required super.description,
    required super.sId,
    required super.features,
    required super.name,
    required super.isActive,
    required super.createdAt,
    required super.price,
    required super.updatedAt,
    required super.iV,
  });

  factory PlansModel.fromJson(Map<String, dynamic> json) {
    return PlansModel(
      isActive: json["isActive"],
      sId: json["_id"],
      features: FeatureModel.fromJson(json["features"]),
      name: json["name"],
      createdAt: json["createdAt"],
      description: json["description"],
      price: json["price"],
      updatedAt: json["updatedAt"],
      iV: json["__v"],
    );
  }
}

class FeatureModel extends FeaturesEntities {
  FeatureModel(
      {required super.aboutUsPage,
      required super.unlimitedCategories,
      required super.unlimitedItems,
      required super.dashboardAnalytics,
      required super.superCategories,
      required super.visualIdentitySettings,
      required super.themeCustomization,
      required super.customFonts,
      required super.customerReviewsPage,
      required super.contacts,
      required super.localization,
      required super.offlineMode,
      required super.themeStoreAccess,
      required super.customDomain});
  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      aboutUsPage: json['aboutUsPage'],
      unlimitedCategories: json['unlimitedCategories'],
      unlimitedItems: json['unlimitedItems'],
      dashboardAnalytics: json['dashboardAnalytics'],
      superCategories: json['superCategories'],
      visualIdentitySettings: json['visualIdentitySettings'],
      themeCustomization: json['themeCustomization'],
      customFonts: json['customFonts'],
      customerReviewsPage: json['customerReviewsPage'],
      contacts: json['contacts'],
      localization: json['localization'],
      offlineMode: json['offlineMode'],
      themeStoreAccess: json['themeStoreAccess'],
      customDomain: json['customDomain'],
    );
  }
}
