import 'package:wallapp/core/utils/constant/color_manger.dart';
 import 'package:flutter/material.dart';

ThemeData ThemeApp() {
    return ThemeData(
        scaffoldBackgroundColor: ColorsManger.transparent,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          backgroundColor: ColorsManger.transparent,
          iconTheme: IconThemeData(color: ColorsManger.white)
        ),
        primaryColor: ColorsManger.primaryColor
      );
  }