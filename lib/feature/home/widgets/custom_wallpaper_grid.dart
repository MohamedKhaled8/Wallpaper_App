import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import '../../Admin/widgets/custom_wallpepr_widgets.dart';
import 'package:wallapp/feature/home/logic/cubit/home_wallpaper_cubit.dart';
import 'package:wallapp/feature/home/widgets/custom_frid_view_wallpaper.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_empty_widgets.dart';

class CustomWallpaperGrid extends StatelessWidget {
  const CustomWallpaperGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeWallpaperCubit>();

    if (cubit.recentWallpaper.isEmpty && cubit.viewState == ViewState.success) {
      return const CustomEmpetyWidgets(title: "No recent wallpaper");
    }

    return CustomGridViewWallpaper(
      itemBuilder: (context, index) {
        final wallpaper = cubit.recentWallpaper[index];
        return CustomWallpperWidgets(
          onTap: () {
            final payload = {
              "wallpaperUrl": wallpaper.wallpaperImage,
              "show_icon": true,
              "wallpaperId": wallpaper.wallpaperId,
              "categoryName": wallpaper.categoryName,
            };
            GoRouter.of(context)
                .push(AppRouter.viewWallPageScreen, extra: payload);
          },
          url: wallpaper.wallpaperImage,
        );
      },
      itemCount: cubit.recentWallpaper.length,
    );
  }
}
