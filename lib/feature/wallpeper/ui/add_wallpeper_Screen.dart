import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/config/space.dart';
import '../../../core/utils/widgets/build_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/error/dialoge_error.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/core/utils/widgets/get_image_path_from_source.dart';
import 'package:wallapp/feature/wallpeper/logic/cubit/add_wallpaper_cubit.dart';
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
                        InkWell(
                          onTap: () async {
                            final result = await GoRouter.of(context).push(
                                AppRouter.categoryScreen,
                                extra: {'is_admin': true});
                            if (result != null) {
                              cubit.selectedCategory = result.toString();
                            }
                          },
                          child: Container(
                            height: 30.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorsManger.white),
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              cubit.selectedCategory,
                              style: const TextStyle(color: ColorsManger.white),
                            ),
                          ),
                        ),
                        verticalSpace(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Wallpepr Image",
                                  style: TextStyle(
                                      color: ColorsManger.white,
                                      fontSize: 18.sp),
                                ),
                                verticalSpace(10),
                                Container(
                                  height: 290.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: ColorsManger.white)),
                                  child: IconButton(
                                    onPressed: () async {
                                      final image =
                                          await getImagePathFromSource();
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
                                  style: TextStyle(
                                      color: ColorsManger.white,
                                      fontSize: 18.sp),
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
                                      border: Border.all(
                                          color: ColorsManger.white)),
                                )
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wallpepr Tages",
                              style: TextStyle(
                                  color: ColorsManger.white, fontSize: 18.sp),
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
                                readOnly: cubit.wallpperTags.length >= 5
                                    ? true
                                    : false,
                                onFieldSubmitted: (value) {
                                  cubit.setWallpeperTages(value);
                                  cubit.controller.clear();
                                },
                                textInputAction: TextInputAction.done,
                                style:
                                    const TextStyle(color: ColorsManger.white),
                                decoration: const InputDecoration(
                                    isDense: true, border: InputBorder.none),
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
                                  border:
                                      Border.all(color: ColorsManger.white)),
                              child: Wrap(
                                spacing: 8,
                                children: List.generate(
                                    cubit.wallpperTags.length, (index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Chip(
                                      label: Text(cubit.wallpperTags[index]),
                                      onDeleted: () {
                                        cubit.removeWallpperTags(
                                            cubit.wallpperTags[index]);
                                      },
                                      deleteIcon: const Icon(Icons.clear),
                                      deleteIconColor: Colors
                                          .red, // Customize delete icon color if needed
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                        verticalSpace(10),
                        CustomButtonAddSections(
                          onTap: () async {
                            if (cubit.selectedCategory.isEmpty) {
                              showMessage(context, "Please select a category");
                              return;
                            }
                            if (cubit.wallpperTags.isEmpty) {
                              showMessage(context, "Please select a category");
                              return;
                            }
                            if (cubit.wallpeprImage == null) {
                              showMessage(
                                  context, "Please select a wallpaper image");
                              return;
                            }
                            await cubit.saveWallpaper();

                            if (cubit.viewState == ViewState.error) {
                              if (context.mounted) {
                                showMessage(context, cubit.message);
                              }
                              return;
                            }
                            if (cubit.viewState == ViewState.success) {
                              if (context.mounted) {
                                showMessage(context,
                                    "Wallpaper was successFully saved and aviable for use",
                                    isError: false);
                              }
                              return;
                            }
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
