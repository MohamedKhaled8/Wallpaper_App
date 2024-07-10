import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/Admin/logic/cubit/admin_cubit.dart';

class CustomAddCategoryAndWallpaperWidget extends StatelessWidget {
  const CustomAddCategoryAndWallpaperWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AdminCubit>();

    return Column(
      children: [
        Container(
          height: 80.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: ColorsManger.primaryColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  GoRouter.of(context).push(AppRouter.addCategoryScreen);
                  break;
                case 1:
                  GoRouter.of(context).push(AppRouter.addWallpeperScreen);
                  break;
                default:
              }
            },
            child: Text(
              cubit.homeActionList[index],
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManger.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
