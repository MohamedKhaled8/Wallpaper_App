import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_container_upload_and_show.dart';

class CategoryPreviewWidget extends StatelessWidget {
  final String text;
  final String? image;

  const CategoryPreviewWidget({
    required this.text,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainerUploadAndShow(
      onTap: () {},
      text: "Category Preview",
      widget: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorsManger.white,
          ),
        ),
      ),
      image: image,
    );
  }
}
