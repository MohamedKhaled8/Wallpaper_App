import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomWallpperWidgets extends StatelessWidget {
  final String url;
  final VoidCallback onTap;
  final bool isLocal;

  const CustomWallpperWidgets({
    Key? key,
    required this.url,
    required this.onTap,
    this.isLocal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorsManger.primaryColor,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: isLocal
                ? FileImage(File(url))
                : CachedNetworkImageProvider(url) as ImageProvider<Object>,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
