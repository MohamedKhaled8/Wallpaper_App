import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// ignore_for_file: public_member_api_docs, sort_constructors_first

class CustomGridViewWallpaper extends StatelessWidget {
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final void Function()? onTap;
  const CustomGridViewWallpaper({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(10.0.r),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder),
    );
  }
}
