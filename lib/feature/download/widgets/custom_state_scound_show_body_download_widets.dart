import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import '../logic/cubit/download_wallpaper_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../home/widgets/custom_frid_view_wallpaper.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/admin/widgets/custom_wallpepr_widgets.dart';



class CustomSateSceoundShowBodyDownloadWigets extends StatelessWidget {
  const CustomSateSceoundShowBodyDownloadWigets({
    super.key,
    required this.isAutoChangeSelection,
  });

  final bool isAutoChangeSelection;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DownloadWallpaperCubit>();

    return CustomGridViewWallpaper(
      itemCount: cubit.downloadFiIle.length,
      itemBuilder: (context, index) {
        final data = cubit.downloadFiIle[index];
        return Stack(
          children: [
            CustomWallpperWidgets(
              onTap: () async {
                if (isAutoChangeSelection) {
                  cubit.setChangeWallpaper = data.path;
                } else {
                  final paylod = {
                    "wallpaperUrl": data.path,
                    "show_icon": true,
                    "isLocalFile": true,
                    "wallpaperId": ''
                  };
                  await context.push(AppRouter.viewWallPageScreen,
                      extra: paylod);
                }
              },
              url: data.path,
              isLocal: true,
            ),
            if (isAutoChangeSelection &&
                cubit.autoChangeWallpaperList.contains(data.path))
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: ColorsManger.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Text(
                    "Auto Change Enable",
                    style: TextStyle(
                      color: ColorsManger.white,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
