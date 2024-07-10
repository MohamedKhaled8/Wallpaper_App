import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/error/dialoge_error.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/setting/logic/cubit/setting_cubit.dart';

void showIntervalDialoge(BuildContext context, SettingCubit settingCubit) {
  if (settingCubit.autoChangeWallpaperList.length < 2) {
    showMessage(
      context,
      "Please select more then 1 wallpaper to automatically change from download",
      onConfimTapped: () async {
        await GoRouter.of(context).push(AppRouter.downloadScreen, extra: true);

        settingCubit
            .saveAutoChangeWallpaper(settingCubit.autoChangeWallpaperList);
      },
    );
    return;
  }

  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: settingCubit,
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            return AlertDialog(
              title: const Text(
                "Select Auto Change Interval And Location",
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(settingCubit.getIntervalList().length,
                      (index) {
                    final data = settingCubit.getIntervalList()[index];
                    final text = "${data.inMinutes} minutes";

                    return InkWell(
                      onTap: () {
                        settingCubit.setAutoChangeInterval(data);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(text),
                            ),
                            if (data == settingCubit.selectedDuration)
                              const Icon(
                                Icons.check,
                                color: ColorsManger.black,
                              )
                          ],
                        ),
                      ),
                    );
                  }),
                  verticalSpace(20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                            settingCubit.wallpaperLocationList.length, (index) {
                          final data =
                              settingCubit.wallpaperLocationList[index];
                          return InkWell(
                            onTap: () {
                              settingCubit.setWallpaperLocation(data);
                              GoRouter.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0.r),
                              decoration: BoxDecoration(
                                color:
                                    settingCubit.selecttedWallpaperLocation ==
                                            data
                                        ? ColorsManger.primaryColor
                                        : ColorsManger.gray,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0.h, horizontal: 5.0.w),
                              child: Text(
                                "${settingCubit.returnLocationNameFormInt(data)} screen",
                                style:
                                    const TextStyle(color: ColorsManger.white),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
