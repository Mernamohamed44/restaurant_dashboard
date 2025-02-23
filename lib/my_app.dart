import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_dashboard/app/routing/app_router.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';

import 'app/helper/extension.dart';

class MyAppHome extends StatelessWidget {
  const MyAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 1024),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        initialRoute: Routes.login,
        onGenerateRoute: AppRouter().generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
