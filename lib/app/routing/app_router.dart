import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/features/Subscription/presentation/screens/Subscription_screen.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/screens/accountScreen.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/screens/login_screen.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/screens/register_screen.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/screens/categories_screen.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/screens/menu_item_screen.dart';
import 'package:restaurant_dashboard/features/reviews/presentation/screens/reviews_screen.dart';
import 'package:restaurant_dashboard/features/settings/presentation/screens/brand_settings.dart';
import 'package:restaurant_dashboard/features/settings/presentation/screens/general_setting_screen.dart';
import 'package:restaurant_dashboard/features/settings/presentation/screens/theme_setting.dart';
import 'package:restaurant_dashboard/features/theme_store/presentation/screens/theme_screen.dart';

import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.login:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return const LoginScreen();
          },
        );
      case Routes.register:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return const RegisterScreen();
          },
        );
      case Routes.dashboard:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return const DashboardScreen();
          },
        );
      case Routes.category:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return const CategoriesScreen();
          },
        );
      case Routes.menuItem:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return MenuItemScreen();
          },
        );
      case Routes.reviews:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return ReviewsScreen();
          },
        );
      case Routes.subscribe:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return SubscriptionScreen();
          },
        );
      case Routes.store:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return ThemeScreen();
          },
        );
      case Routes.generalSetting:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return GeneralSettingScreen();
          },
        );
      case Routes.brandSetting:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return BrandSettingScreen();
          },
        );
      case Routes.themeSetting:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return ThemeSettingScreen();
          },
        );
      case Routes.account:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return AccountScreen();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
