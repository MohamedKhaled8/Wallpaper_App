import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../core/utils/constant/my_string.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wallapp/core/utils/config/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  final _appRef = SharedPreferences.getInstance();
  String _appVersion = '';
  String get appVersion => _appVersion;
  Duration _selectedDuration = const Duration(minutes: 0);
  Duration get selectedDuration => _selectedDuration;

  int _selecttedWallpaperLocation = WallpaperManager.HOME_SCREEN;
  int get selecttedWallpaperLocation => _selecttedWallpaperLocation;
  List<String> _autoChangeWallpaperList = [];
  List<String> get autoChangeWallpaperList => _autoChangeWallpaperList;

  set setChangeWallpaper(String image) {
    if (_autoChangeWallpaperList.contains(image)) {
      _autoChangeWallpaperList.remove(image);
    } else {
      _autoChangeWallpaperList.add(image);
    }
    emit(SettingInitial());
  }

  List<Duration> getIntervalList() {
    return List.generate(4, (index) => Duration(minutes: 3 * (index + 1)));
  }

  List<int> wallpaperLocationList = [
    WallpaperManager.HOME_SCREEN,
    WallpaperManager.LOCK_SCREEN,
    WallpaperManager.BOTH_SCREEN,
  ];

  String returnLocationNameFormInt(int location) {
    String text;

    switch (location) {
      case 1:
        text = 'Home';
      case 2:
        text = 'Lock';
      case 3:
        text = 'Both';
      default:
        text = 'Home';
    }
    return text;
  }

  Future<void> setAutoChangeInterval(Duration interval) async {
    final value = await _appRef;
    value.setInt(intervalKey, interval.inMinutes);
    getAutoChangeInterval();
    emit(SettingIntervalUpdated(_selectedDuration));
  }

  Future<int> getAutoChangeInterval() async {
    final value = await _appRef;
    final interval = value.getInt(intervalKey) ?? 0;
    _selectedDuration = Duration(minutes: interval);
    emit(SettingIntervalUpdated(_selectedDuration));
    _setWorkManger(interval);
    return interval;
  }

  void _setWorkManger(int interval) {
    if (interval >= 3) {
      Future.delayed(const Duration(seconds: 3), () {
        Workmanager().registerPeriodicTask(
          'my_app',
          'wallpaper change',
          frequency: Duration(minutes: interval),
        );
      });
    }
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _appVersion = packageInfo.version;
    emit(SettingInitial());
  }

  Future<void> setWallpaperLocation(int location) async {
    final value = await _appRef;
    value.setInt(wallpaperLocationKey, location);
    getWallpaperLocation();
    emit(SettingInitial());
  }

  Future<int> getWallpaperLocation() async {
    final value = await _appRef;
    final location =
        value.getInt(wallpaperLocationKey) ?? WallpaperManager.HOME_SCREEN;

    _selecttedWallpaperLocation = location;

    emit(SettingInitial());

    return location;
  }

  Future<void> saveAutoChangeWallpaper(List<String> images) async {
    final value = await _appRef;
    value.setStringList(autoChangeWallpaperKey, images);
    getAutoChangeWallpaperList();
    emit(SettingInitial());
  }

  Future<List<String>> getAutoChangeWallpaperList() async {
    final value = await _appRef;
    final list = value.getStringList(autoChangeWallpaperKey) ?? [];
    _autoChangeWallpaperList = list;
    emit(SettingInitial());
    return list;
  }

  Future<bool> autoChangeWallpaper() async {
    final interval = await getAutoChangeInterval();
    final location = await getWallpaperLocation();

    appLogger("Interval and location: $interval, $location");

    final downloadFiles = await getAutoChangeWallpaperList();

    if (downloadFiles.isNotEmpty) {
      final rand = Random().nextInt(downloadFiles.length);
      await WallpaperManager.setWallpaperFromFile(
          downloadFiles[rand], location);

      appLogger("Wallpaper allied successfully");

      return true;
    }

    return false;
  }
}
