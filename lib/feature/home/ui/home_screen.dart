import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/widgets/custom_loading_widgets.dart';
import 'package:wallapp/feature/home/widgets/custom_wallpaper_grid.dart';
import 'package:wallapp/feature/home/logic/cubit/home_wallpaper_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_empty_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeWallpaperCubit()..fetchRecentWallpaper(),
      child: BlocBuilder<HomeWallpaperCubit, HomeWallpaperState>(
        builder: (context, state) {
          var cubit = context.read<HomeWallpaperCubit>();
          if (cubit.viewState == ViewState.busy) {
            return const CustomLoadingWidget();
          }
          if (cubit.recentWallpaper.isEmpty &&
              cubit.viewState == ViewState.success) {
            return const CustomEmpetyWidgets(title: "No recent wallpaper");
          }
          return const CustomWallpaperGrid();
        },
      ),
    );
  }
}
