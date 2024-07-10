import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import '../../Admin/widgets/custom_wallpepr_widgets.dart';
import 'package:wallapp/feature/home/widgets/custom_frid_view_wallpaper.dart';
import 'package:wallapp/feature/favorite_screend.art/logic/cubit/favorite_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_empty_widgets.dart';


class CustomBodyFavoriteScreenWidget extends StatelessWidget {
  const CustomBodyFavoriteScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<FavoriteCubit>();

    return Scaffold(
      body: (cubit.favoriteList.isEmpty)
          ? const CustomEmpetyWidgets(title: 'No Recent Favorite')
          : CustomGridViewWallpaper(
              itemCount: cubit.favoriteList.length,
              itemBuilder: (context, index) {
                final data = cubit.favoriteList[index];

                return CustomWallpperWidgets(
                  onTap: () async {
                    final payload = {
                      "wallpaperUrl": data.wallpaperImage,
                      "show_icon": true,
                      "wallpaperId": data.id
                    };
                    await GoRouter.of(context)
                        .push(AppRouter.viewWallPageScreen, extra: payload);
                    cubit.retrieveFavorite();
                  },
                  url: data.wallpaperImage,
                );
              },
            ),
    );
  }
}
