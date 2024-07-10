import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/bottom_navigation_bar/logic/cubit/bottom_navigation_bar_cubit.dart';

class CustomBodyBottomNavBar extends StatelessWidget {
  const CustomBodyBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<BottomNavigationBarCubit>();

    return SafeArea(
      child: Column(
        children: [
          if (cubit.index == 0)
            InkWell(
              onTap: () {
                GoRouter.of(context).push(AppRouter.searchScreen);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                height: 40.h,
                width: 340.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorsManger.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    horizintalSpace(20),
                    Icon(
                      Icons.search,
                      color: ColorsManger.white,
                      size: 16.sp,
                    ),
                    horizintalSpace(20),
                    Text(
                      "  Search Wallpeper",
                      style:
                          TextStyle(color: ColorsManger.white, fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
            ),
          verticalSpace(20),
          Expanded(child: cubit.bottomNavigationBarScreen[cubit.index]),
        ],
      ),
    );
  }
}
