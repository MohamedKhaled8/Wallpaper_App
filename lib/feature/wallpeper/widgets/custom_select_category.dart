import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/wallpeper/logic/cubit/add_wallpaper_cubit.dart';

class CustomSelectCategory extends StatelessWidget {
  const CustomSelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<AddWallpaperCubit>();

    return InkWell(
      onTap: () async {
        final result = await GoRouter.of(context)
            .push(AppRouter.categoryScreen, extra: {'is_admin': true});
        if (result != null) {
          cubit.selectedCategory = result.toString();
        }
      },
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            border: Border.all(color: ColorsManger.white),
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          cubit.selectedCategory,
          style: const TextStyle(color: ColorsManger.white),
        ),
      ),
    );
  }
}
