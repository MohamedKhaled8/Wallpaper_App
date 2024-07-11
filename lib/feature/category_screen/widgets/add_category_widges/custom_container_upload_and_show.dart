import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';

class CustomContainerUploadAndShow extends StatelessWidget {
  final String text;
  final Widget widget;
  final void Function()? onTap;
  final String? image;
  const CustomContainerUploadAndShow({
    Key? key,
    required this.text,
    required this.widget,
    required this.onTap,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;

    if (image != null) {
      if (image!.startsWith('/data/') || image!.startsWith('/storage/')) {
        decorationImage = DecorationImage(
          image: FileImage(File(image!)),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            // Handle the error gracefully
            debugPrint('Error loading image from file: $exception');
          },
        );
      } else {
        decorationImage = DecorationImage(
          image: NetworkImage(image!),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            // Handle the error gracefully
            debugPrint('Error loading image from network: $exception');
          },
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 18.sp, color: ColorsManger.white),
        ),
        verticalSpace(10),
        InkWell(
          onTap: onTap,
          child: Container(
              padding: EdgeInsets.all(10.r),
              margin: EdgeInsets.only(bottom: 10.h),
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: ColorsManger.white),
                image: decorationImage,
              ),
              child: widget),
        ),
      ],
    );
  }
}
