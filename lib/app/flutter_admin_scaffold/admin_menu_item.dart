import 'package:flutter/material.dart';

class AdminMenuItem {
  const AdminMenuItem({
    required this.title,
    this.route,
    this.children = const [],
    required this.unSelectedWidget,
    required this.selectedWidget,
  });

  final String title;
  final String? route;
  final List<AdminMenuItem> children;
  final Widget unSelectedWidget;
  final Widget selectedWidget;
}
