import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';

class CustomEmpetyWidgets extends StatelessWidget {
  final String title;
  const CustomEmpetyWidgets({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset("assets/json/notfoundwallpepr.json" , 
            
            ),
            verticalSpace(20),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: ColorsManger.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
