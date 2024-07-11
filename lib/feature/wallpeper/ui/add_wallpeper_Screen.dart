import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/space.dart';
import '../../../core/utils/widgets/build_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/wallpeper/widgets/custom_select_category.dart';
import 'package:wallapp/feature/wallpeper/logic/cubit/add_wallpaper_cubit.dart';
import 'package:wallapp/feature/wallpeper/widgets/custom_wallpaper_tages_widget.dart';
import 'package:wallapp/feature/wallpeper/widgets/custom_add_and_review_wallpaper.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_button_add_sections.dart';

class AddWallpeperScreen extends StatelessWidget {
  const AddWallpeperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWallpaperCubit(),
      child: BlocBuilder<AddWallpaperCubit, AddWallpaperState>(
        builder: (context, state) {
          var cubit = context.read<AddWallpaperCubit>();
          return Scaffold(
              appBar: buildAppBar(title: const Text("Add Wallpeper")),
              body: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        Text(
                          " Wallpper Name",
                          style: TextStyle(
                              fontSize: 18.sp, color: ColorsManger.white),
                        ),
                        verticalSpace(10),
                        const CustomSelectCategory(),
                        verticalSpace(20),
                        const CustomAddAndRivewWallpaperWidget(),
                        verticalSpace(10),
                        const CustomWallpaperTagesWidget(),
                        verticalSpace(10),
                        CustomButtonAddSections(
                          onTap: () {
                            cubit.checkStateCategory(context);
                          },
                        )
                      ],
                    ))
                  ],
                ),
              ));
        },
      ),
    );
  }
}
