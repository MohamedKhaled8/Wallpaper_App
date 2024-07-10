import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_container_upload_and_show.dart';

class UploadButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const UploadButtonWidget({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainerUploadAndShow(
      onTap: onTap,
      text: "Category Preview",
      widget: Align(
        alignment: Alignment.center,
        child: IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.upload),
          color: ColorsManger.white,
        ),
      ),
      image: null, // Change this as per your logic
    );
  }
}
