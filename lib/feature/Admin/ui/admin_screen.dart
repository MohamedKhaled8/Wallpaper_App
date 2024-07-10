import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_wallpepr_widgets.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/Admin/logic/cubit/admin_cubit.dart';
import 'package:wallapp/feature/home/widgets/custom_frid_view_wallpaper.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_empty_widgets.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AdminCubit()..getAdminWallpepr();
      },
      child: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          var cubit = context.read<AdminCubit>();
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20.r),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(children: [
                      ...List.generate(cubit.homeActionList.length, (index) {
                        final data = cubit.homeActionList[index];
                        return InkWell(
                          onTap: () {
                            switch (index) {
                              case 0:
                                GoRouter.of(context)
                                    .push(AppRouter.addCategoryScreen);
                              case 1:
                                GoRouter.of(context)
                                    .push(AppRouter.addWallpeperScreen);
                                break;
                              default:
                            }
                          },
                          child: Container(
                            height: 80.h,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10.h),
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: ColorsManger.primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              data,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManger.white,
                              ),
                            ),
                          ),
                        );
                      }),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.r),
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          "My Gallary",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManger.white,
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      if (cubit.adminWallpaper.isEmpty &&
                          cubit.viewState == ViewState.success)
                        const CustomEmpetyWidgets(title: "No Gallery wallpaper")
                      else
                        CustomGridViewWallpaper(
                          itemCount: cubit.adminWallpaper.length,
                          itemBuilder: (context, index) {
                            final wallpaper = cubit.adminWallpaper[index];
                            return CustomWallpperWidgets(
                              onTap: () {},
                              url: wallpaper.wallpaperImage,
                            );
                          },
                        ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
