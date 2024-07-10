import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';

class CategoryNameInputWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CategoryNameInputWidget({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      margin: EdgeInsets.only(bottom: 10.h),
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorsManger.white),
      ),
      child: TextFormField(
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
        style: const TextStyle(color: ColorsManger.white),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
