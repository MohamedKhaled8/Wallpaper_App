import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../../setting/ui/setting_screen.dart';
import 'package:wallapp/feature/home/ui/home_screen.dart';
import '../../../category_screen/ui/category_screen.dart';
import 'package:wallapp/feature/Admin/ui/admin_screen.dart';
import '../../../favorite_screend.art/ui/favorite_screen.dart';

part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit() : super(BottomNavigationBarInitial());

  int _index = 0;
  int get index => _index;

  void setIndex(int value) {
    _index = value;
    emit(BottomNavigationBarUpdated(_index));
  }

  List<Map<String, dynamic>> bottomNavItems = [
    {"label": "Home", "icon": Icons.home},
    {"label": "Category", "icon": Icons.category},
    {"label": "Favorite", "icon": Icons.favorite},
    {"label": "Setting", "icon": Icons.settings},
    {"label": "Admin", "icon": Icons.admin_panel_settings},
  ];
  List<Widget> bottomNavigationBarScreen = const [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen(),
    AdminScreen(),
    // AddWallpeperScreen(),
  ];
  IconData getOutlinedIcon(IconData filledIcon) {
    switch (filledIcon) {
      case Icons.home:
        return Icons.home_outlined;
      case Icons.category:
        return Icons.category_outlined;
      case Icons.favorite:
        return Icons.favorite_border_outlined;
      case Icons.settings:
        return Icons.settings_outlined;
      case Icons.admin_panel_settings:
        return Icons.admin_panel_settings_outlined;
      default:
        return filledIcon;
    }
  }
}
