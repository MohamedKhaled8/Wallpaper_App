import 'package:flutter/material.dart';

AppBar buildAppBar({Widget? title, List<Widget>? actions}) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    title: title,
    actions: actions ?? [],
    
  );
}
