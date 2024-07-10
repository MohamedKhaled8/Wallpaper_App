import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/core/utils/widgets/show_interval_dialoge.dart';
import 'package:wallapp/feature/setting/logic/cubit/setting_cubit.dart';
import 'package:wallapp/feature/splash_screen/logic/cubit/auth_cubit.dart';
import 'package:wallapp/feature/setting/widgets/custom_button_setting_screen_widget.dart';
import 'package:wallapp/feature/setting/widgets/custom_list_title_setting_screen_widget.dart';

class CustomRepetListTitleSettingScreenWidgets extends StatelessWidget {
  const CustomRepetListTitleSettingScreenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SettingCubit>();

    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomListTileSettingScreenWidget(
              selected: true,
              onChanged: (value) {
                if (cubit.selectedDuration.inMinutes < 3) {
                  showIntervalDialoge(context, cubit);
                } else {
                  cubit.setAutoChangeInterval(const Duration(minutes: 0));
                }
              },
              onTap: () {
                showIntervalDialoge(context, cubit);
              },
              subtitle: cubit.selectedDuration.inMinutes >= 3
                  ? '${cubit.selectedDuration.inMinutes} minutes'
                  : 'Select Interval',
              title: 'Select Interval',
              value: cubit.selectedDuration.inMinutes >= 3,
            ),
            CustomListTileSettingScreenWidget(
              selected: false,
              onChanged: (bool) {},
              onTap: () async {
                final result =
                    await context.push(AppRouter.downloadScreen, extra: true);
                if (result != null && result == true) {
                  cubit.getAutoChangeWallpaperList();
                }
              },
              subtitle: "${cubit.autoChangeWallpaperList.length} selected",
              title: "Select Auto Change Wallpaper",
              value: false,
            ),
            CustomListTileSettingScreenWidget(
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: ColorsManger.white),
              onChanged: (bool) {},
              onTap: () {
                GoRouter.of(context).push(
                  AppRouter.downloadScreen,
                );
              },
              subtitle: "",
              leading: const Icon(Icons.download, color: ColorsManger.white),
              title: "Download",
              value: true,
              selected: false,
            ),
            CustomListTileSettingScreenWidget(
              onChanged: (bool) {},
              onTap: () {},
              subtitle: "LogOut",
              trailing: CustomButtonSettingScreenWiget(
                text: "logOut",
                onTap: () async {
                  final cubit = context.read<AuthCubit>();
                  await cubit.signOut();

                  ///هذا السطر من الشيفرة يقوم بالتحقق مما إذا كان الـ context لا يزال mounted (أي لا يزال مرتبطًا بشاشة فعالة) قبل القيام بعملية التوجيه إلى مسار جديد باستخدام GoRouter. إذا كان الـ context غير موجود (unmounted)، فإن محاولة استخدامه يمكن أن تؤدي إلى أخطاء في وقت التشغيل.
                  if (context.mounted) {
                    GoRouter.of(context).pushReplacement('/');
                  }
                },
              ),
              title: "LogOut",
              value: true,
              selected: false,
            ),
            (MediaQuery.of(context).size.height ~/ 3).verticalSpace,
            CustomListTileSettingScreenWidget(
              onChanged: (bool) {},
              onTap: () {},
              subtitle: "version",
              trailing: Text(
                cubit.appVersion,
                style: const TextStyle(color: ColorsManger.white),
              ),
              title: "Current Version",
              value: true,
              selected: false,
            ),
          ],
        );
      },
    );
  }
}
