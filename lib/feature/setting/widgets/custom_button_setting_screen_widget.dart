import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';

class CustomButtonSettingScreenWiget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const CustomButtonSettingScreenWiget({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(ColorsManger.primaryColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                side: const BorderSide(color: ColorsManger.white)))),
        child: Text(
          text,
          style: const TextStyle(color: ColorsManger.white),
        ));
  }
}
