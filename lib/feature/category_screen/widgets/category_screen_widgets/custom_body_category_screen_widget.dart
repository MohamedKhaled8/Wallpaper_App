import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/category_screen/data/model/category_model.dart';
import 'package:wallapp/feature/category_screen/logic/cubit/category_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_container_upload_and_show.dart';

class CustomBodyCategoryScreenWidgets extends StatelessWidget {
  final bool isAdmin;
  final List<CategorySModel> categories;
  const CustomBodyCategoryScreenWidgets({
    Key? key,
    required this.isAdmin,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CategoryCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.r),
      child: GridView.builder(
        itemCount: cubit.categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.r,
          childAspectRatio: 0.86.r,
        ),
        itemBuilder: (context, index) {
          return CustomContainerUploadAndShow(
            onTap: () {
              if (isAdmin) {
                GoRouter.of(context)
                    .pop(cubit.categories[index].categoryName.toString());
              } else {
                final name = {
                  "categoryName": cubit.categories[index].categoryName
                };
                GoRouter.of(context)
                    .push(AppRouter.viewCategoryScreen, extra: name);
              }
            },
            text: "",
            widget: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                categories[index].categoryName,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: ColorsManger.white,
                ),
              ),
            ),
            image: categories[index].categoryImage,
          );
        },
      ),
    );
  }
}
