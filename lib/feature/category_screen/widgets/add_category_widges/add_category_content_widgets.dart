import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/core/utils/widgets/get_image_path_from_source.dart';
import 'package:wallapp/feature/category_screen/logic/cubit/category_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/save_button_widgets.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/upload_button_wigets.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/category_preview_widgets.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/category_name_input_widget.dart';

class AddCategoryContentWidget extends StatelessWidget {
  const AddCategoryContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<CategoryCubit>();

    return Padding(
      padding: EdgeInsets.all(20.r),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Category Name",
              style: TextStyle(
                fontSize: 18.sp,
                color: ColorsManger.white,
              ),
            ),
            verticalSpace(10),
            CategoryNameInputWidget(
              onChanged: (value) {
                cubit.categoryName = value;
              },
            ),
            verticalSpace(20),
            CategoryPreviewWidget(
              text: cubit.categoryName,
              image: cubit.categoryImage,
            ),
            verticalSpace(20),
            UploadButtonWidget(
              onTap: () async {
                final image = await getImagePathFromSource();
                if (image != null) {
                  cubit.categoryImage = image;
                }
              },
            ),
            const SaveButtonWidget(),
            verticalSpace(50),
          ],
        ),
      ),
    );
  }
}
