import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';

class CustomListTileSettingScreenWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool value;
  final Function(bool) onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool selected;
  const CustomListTileSettingScreenWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.value,
    required this.onChanged,
    required this.selected,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.r),
      title: Text(
        title,
        style: const TextStyle(color: ColorsManger.white),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: ColorsManger.gray),
      ),
      leading: leading,
      trailing: selected == true
          ? Switch.adaptive(value: value, onChanged: onChanged)
          : trailing,
      onTap: onTap,
    );
  }
}
