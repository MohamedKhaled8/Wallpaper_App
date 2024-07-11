import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/wallpeper/logic/cubit/add_wallpaper_cubit.dart';

class CustomWallpaperTagesWidget extends StatelessWidget {
  const CustomWallpaperTagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<AddWallpaperCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Wallpepr Tages",
          style: TextStyle(color: ColorsManger.white, fontSize: 18.sp),
        ),
        verticalSpace(10),
        Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(
                color: ColorsManger.white,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: cubit.controller,
            readOnly: cubit.wallpperTags.length >= 5 ? true : false,
            onFieldSubmitted: (value) {
              cubit.setWallpeperTages(value);
              cubit.controller.clear();
            },
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: ColorsManger.white),
            decoration:
                const InputDecoration(isDense: true, border: InputBorder.none),
          ),
        ),
        verticalSpace(10),
        Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.only(bottom: 10.h),
          width: MediaQuery.of(context).size.width,
          height: 120.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorsManger.white)),
          child: Wrap(
            spacing: 8,
            children: List.generate(cubit.wallpperTags.length, (index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Chip(
                  label: Text(cubit.wallpperTags[index]),
                  onDeleted: () {
                    cubit.removeWallpperTags(cubit.wallpperTags[index]);
                  },
                  deleteIcon: const Icon(Icons.clear),
                  deleteIconColor:
                      Colors.red, // Customize delete icon color if needed
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}