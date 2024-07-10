import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first


class CustomButtonAddSections extends StatelessWidget {
  final void Function()? onTap;
  const CustomButtonAddSections({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ColorsManger.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: ColorsManger.white)))),
          onPressed: onTap,
          child: const Text(
            "Containue",
            style: TextStyle(color: ColorsManger.black),
          )),
    );
  }
}
