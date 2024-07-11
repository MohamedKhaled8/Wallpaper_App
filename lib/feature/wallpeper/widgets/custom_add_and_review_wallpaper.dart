import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/core/utils/widgets/get_image_path_from_source.dart';
import 'package:wallapp/feature/wallpeper/logic/cubit/add_wallpaper_cubit.dart';


class CustomAddAndRivewWallpaperWidget extends StatelessWidget {
  const CustomAddAndRivewWallpaperWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<AddWallpaperCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          children: [
            Text(
              "Wallpepr Image",
              style: TextStyle(color: ColorsManger.white, fontSize: 18.sp),
            ),
            verticalSpace(10),
            Container(
              height: 290.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorsManger.white)),
              child: IconButton(
                onPressed: () async {
                  final image = await getImagePathFromSource();
                  cubit.wallpeprImage = image;
                },
                icon: const Icon(Icons.upload),
                color: ColorsManger.white,
              ),
            )
          ],
        )),
        horizintalSpace(10),
        Expanded(
            child: Column(
          children: [
            Text(
              "Wallpepr Preview",
              style: TextStyle(color: ColorsManger.white, fontSize: 18.sp),
            ),
            verticalSpace(10),
            Container(
              height: 290.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: cubit.wallpeprImage == null
                      ? null
                      : DecorationImage(
                          image: FileImage(
                            File(cubit.wallpeprImage!),
                          ),
                          fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorsManger.white)),
            )
          ],
        )),
      ],
    );
  }
}
