import 'package:flutter/material.dart';
import 'package:wallapp/wall_app.dart';
import 'package:workmanager/workmanager.dart';
import 'package:wallapp/core/utils/dependency/get_it.dart';
import 'package:wallapp/core/utils/config/app_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/feature/setting/logic/cubit/setting_cubit.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    appLogger("Running callback dispatcher");

    final result = await SettingCubit().autoChangeWallpaper();
    return result;
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();

  await setupLocator();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(const WallApp());
}
