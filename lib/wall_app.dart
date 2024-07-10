import 'core/Router/go_route.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/theme/Theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WallApp extends StatelessWidget {
  const WallApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeApp(),
        routerConfig: AppRouter.router,
        title: 'WallApp',
      ),
    );
  }
}
