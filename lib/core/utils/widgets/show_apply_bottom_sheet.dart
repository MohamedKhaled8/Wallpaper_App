import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/setting/widgets/custom_list_title_setting_screen_widget.dart';

void showApplyBottomSheet(
  BuildContext context, {
  VoidCallback? onHomeTapped,
  VoidCallback? onLockTapped,
  VoidCallback? onBothTapped,
}) {
  showModalBottomSheet(
      backgroundColor: ColorsManger.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomListTileSettingScreenWidget(
                  leading: const Icon(
                    Icons.home,
                    color: ColorsManger.white,
                  ),
                  title: "Home Screen",
                  subtitle: "",
                  onTap: () {
                    GoRouter.of(context).pop();
                    onHomeTapped!();
                  },
                  value: false,
                  onChanged: (value) {},
                  selected: false),
              CustomListTileSettingScreenWidget(
                  leading: const Icon(
                    Icons.screen_lock_landscape,
                    color: ColorsManger.white,
                  ),
                  title: "Lock Screen",
                  subtitle: "",
                  onTap: () {
                    GoRouter.of(context).pop();
                    onLockTapped!();
                  },
                  value: false,
                  onChanged: (value) {},
                  selected: false),
              CustomListTileSettingScreenWidget(
                  leading: const Icon(
                    Icons.screen_lock_landscape,
                    color: ColorsManger.white,
                  ),
                  title: "Both Screen",
                  subtitle: "",
                  onTap: () {
                    GoRouter.of(context).pop();
                    onBothTapped!();
                  },
                  value: false,
                  onChanged: (value) {},
                  selected: false),
              CustomListTileSettingScreenWidget(
                  leading: const Icon(
                    Icons.cancel,
                    color: ColorsManger.white,
                  ),
                  title: "Cansel",
                  subtitle: "",
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  value: false,
                  onChanged: (value) {},
                  selected: false),
            ],
          ),
        );
      });
}
