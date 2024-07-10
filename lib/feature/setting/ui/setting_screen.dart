import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/setting/logic/cubit/setting_cubit.dart';
import 'package:wallapp/feature/setting/widgets/custom_repet_list_title_setting_screen_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()
        ..getAutoChangeInterval()
        ..getAppVersion()
        ..getWallpaperLocation()
        ..getAutoChangeWallpaperList(),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20.r),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Auto Change Wallpaper",
                      style:
                          TextStyle(fontSize: 18.sp, color: ColorsManger.white),
                    ),
                    verticalSpace(20),
                    const CustomRepetListTitleSettingScreenWidgets(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
