import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/bloc_observer/bloc_observer.dart';
import 'package:restaurant_dashboard/app/caching/shared_prefs.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Caching.init(),
    setupGetIt(),
  ]);
  Bloc.observer = MyBlocObserver();
  runApp(const MyAppHome());
}
