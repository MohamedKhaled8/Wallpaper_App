import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/widgets/build_app_bar.dart';
import 'package:wallapp/feature/admin/widgets/custom_wallpepr_widgets.dart';
import 'package:wallapp/feature/home/widgets/custom_frid_view_wallpaper.dart';
import 'package:wallapp/feature/category_screen/logic/cubit/category_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_empty_widgets.dart';

class ViewCategoryScreen extends StatelessWidget {
  final String categoryName;
  const ViewCategoryScreen({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        var cubit = context.read<CategoryCubit>();

        return Scaffold(
            appBar: buildAppBar(title: Text(categoryName)),
            body: cubit.categoryWallpaper.isEmpty &&
                    cubit.viewState == ViewState.success
                ? const CustomEmpetyWidgets(
                    title: "No categoryWallpaper wallpaper")
                : CustomGridViewWallpaper(
                    itemCount: cubit.categoryWallpaper.length,
                    itemBuilder: (context, index) {
                      final wallpaper = cubit.categoryWallpaper[index];

                      return CustomWallpperWidgets(
                        onTap: () {},
                        url: wallpaper.wallpaperImage,
                      );
                    },
                  ));
      },
    );
  }
}
