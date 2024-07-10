import 'package:flutter/material.dart';
import '../../../core/utils/config/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/widgets/build_app_bar.dart';
import 'package:wallapp/feature/download/logic/cubit/download_wallpaper_cubit.dart';
import 'package:wallapp/feature/download/widgets/custom_state_scound_show_body_download_widets.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_empty_widgets.dart';


class DownloadScreen extends StatelessWidget {
  final bool isAutoChangeSelection;
  const DownloadScreen({
    Key? key,
    this.isAutoChangeSelection = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        // GoRouter.of(context).push(AppRouter.bottomNavigationBar);
        return false;
      },
      child: BlocBuilder<DownloadWallpaperCubit, DownloadWallpaperState>(
        builder: (context, state) {
          var cubit = context.read<DownloadWallpaperCubit>();
          return Scaffold(
              appBar: buildAppBar(
                title: const Row(
                  children: [
                    Text("Download"),
                  ],
                ),
              ),
              body: (cubit.downloadFiIle.isEmpty &&
                      cubit.viewState == ViewState.success)
                  ? const CustomEmpetyWidgets(title: "No Recent Download")
                  : CustomSateSceoundShowBodyDownloadWigets(
                      isAutoChangeSelection: isAutoChangeSelection));
        },
      ),
    );
  }
}
