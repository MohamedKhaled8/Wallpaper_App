import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/error/dialoge_error.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/core/utils/widgets/build_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallapp/core/utils/widgets/show_apply_bottom_sheet.dart';
import 'package:wallapp/feature/download/logic/cubit/download_wallpaper_cubit.dart';
import 'package:wallapp/feature/favorite_screend.art/data/model/favorite_model.dart';
import 'package:wallapp/feature/favorite_screend.art/logic/cubit/favorite_cubit.dart';
import 'package:wallapp/feature/setting/widgets/custom_button_setting_screen_widget.dart';

class ViewWallPageScreen extends StatelessWidget {
  final String url;
  final String wallpaperId;
  final String categoryName;
  final bool isLocalFile;
  final bool showFaouriteIcon;

  const ViewWallPageScreen({
    Key? key,
    required this.url,
    required this.wallpaperId,
    required this.categoryName,
    this.isLocalFile = false,
    this.showFaouriteIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        var cubit = context.read<FavoriteCubit>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: buildAppBar(
              title: Text(
                categoryName,
                style: const TextStyle(color: ColorsManger.white),
              ),
              actions: [
                if (!isLocalFile)
                  IconButton(
                      onPressed: () {
                        if (cubit.isFavorite) {
                          cubit.deleteFromFavorite(wallpaperId);
                        } else {
                          cubit.addToFavorite(FavoriteModel(
                              id: wallpaperId,
                              wallpaperImage: url,
                              dateCreated:
                                  DateTime.now().millisecondsSinceEpoch));
                        }
                      },
                      icon: Icon(
                        cubit.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: cubit.isFavorite
                            ? ColorsManger.primaryColor
                            : ColorsManger.white,
                      ))
              ]),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: isLocalFile
                      ? FileImage(File(url))
                      : CachedNetworkImageProvider(url)
                          as ImageProvider<Object>,
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned(
                    bottom: 50.w,
                    left: 30.w,
                    right: 30.w,
                    child: Row(
                      children: [
                        Expanded(
                            child: BlocProvider(
                          create: (context) => DownloadWallpaperCubit(
                            isLocalFile: isLocalFile,
                            url: url,
                          ),
                          child: BlocBuilder<DownloadWallpaperCubit,
                              DownloadWallpaperState>(
                            builder: (context, state) {
                              var cubit =
                                  context.read<DownloadWallpaperCubit>();
                              return CustomButtonSettingScreenWiget(
                                text: "Apply Wallpaper",
                                onTap: () {
                                  if (Platform.isIOS) {
                                    cubit.downloadIosFile(context);
                                    return;
                                  }
                                  showApplyBottomSheet(
                                    context,
                                    onHomeTapped: () async {
                                      Navigator.pop(context);
                                      await cubit
                                          .setWallpaperForHomeScreen(context);
                                    },
                                    onLockTapped: () async {
                                      Navigator.pop(context);
                                      await cubit
                                          .setWallpaperForLockScreen(context);
                                    },
                                    onBothTapped: () async {
                                      Navigator.pop(context);
                                      await cubit
                                          .setWallpaperForBothScreens(context);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        )),
                        horizintalSpace(20),
                        if (!isLocalFile)
                          BlocProvider(
                            create: (context) => DownloadWallpaperCubit(
                              isLocalFile: isLocalFile,
                              url: url,
                            )..getDownloadFiles(),
                            child: BlocBuilder<DownloadWallpaperCubit,
                                DownloadWallpaperState>(
                              builder: (context, state) {
                                var cubit =
                                    context.read<DownloadWallpaperCubit>();

                                return FloatingActionButton(
                                    backgroundColor: ColorsManger.white,
                                    mini: true,
                                    child: const Icon(
                                      Icons.download,
                                      color: ColorsManger.primaryColor,
                                    ),
                                    onPressed: () async {
                                      await cubit.downloadFile(url, context);
                                      if (cubit.viewState ==
                                          ViewState.success) {
                                        if (context.mounted) {
                                          showMessage(context,
                                              "File downloaded successfully. Go to app downloads to see it",
                                              onConfimTapped: () {
                                            GoRouter.of(context).push(
                                                AppRouter.bottomNavigationBar);
                                          }, isError: false);
                                          return;
                                        }
                                      }
                                    });
                              },
                            ),
                          )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
