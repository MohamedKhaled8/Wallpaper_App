import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/feature/bottom_navigation_bar/logic/cubit/bottom_navigation_bar_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<BottomNavigationBarCubit>();

    return BottomNavigationBar(
      selectedItemColor: ColorsManger.primaryColor,
      currentIndex: cubit.index,
      unselectedItemColor: ColorsManger.white,
      onTap: (value) => cubit.setIndex(value),
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorsManger.black,
      items: List.generate(cubit.bottomNavItems.length, (index) {
        IconData selectedIconData = cubit.bottomNavItems[index]['icon'];
        IconData unselectedIconData = cubit.getOutlinedIcon(selectedIconData);
        return BottomNavigationBarItem(
          icon: Icon(
            cubit.index == index ? selectedIconData : unselectedIconData,
          ),
          label: cubit.bottomNavItems[index]['label'],
        );
      }),
    );
  }
}