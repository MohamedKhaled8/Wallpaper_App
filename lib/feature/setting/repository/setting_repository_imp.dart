import 'dart:math';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallapp/feature/setting/repository/setting_repository.dart';

class SettingRepositoryImp extends SettingRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final WallpaperManager wallpaperManager = WallpaperManager();

  @override
  Future<void> setAutoChangeInterval(Duration interval) async {
    final prefs = await _prefs;
    await prefs.setInt('intervalKey', interval.inMinutes);
  }

  @override
  Future<int> getAutoChangeInterval() async {
    final prefs = await _prefs;
    return prefs.getInt('intervalKey') ?? 0;
  }

  Future<void> setWallpaperLocation(int location) async {
    final prefs = await _prefs;
    await prefs.setInt('wallpaperLocationKey', location);
  }

  Future<int> getWallpaperLocation() async {
    final prefs = await _prefs;
    return prefs.getInt('wallpaperLocationKey') ?? WallpaperManager.HOME_SCREEN;
  }

  Future<void> saveAutoChangeWallpaper(List<String> images) async {
    final prefs = await _prefs;
    await prefs.setStringList('autoChangeWallpaperKey', images);
  }

  Future<List<String>> getAutoChangeWallpaperList() async {
    final prefs = await _prefs;
    return prefs.getStringList('autoChangeWallpaperKey') ?? [];
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<bool> autoChangeWallpaper() async {
    final interval = await getAutoChangeInterval();
    final location = await getWallpaperLocation();
    final downloadFiles = await getAutoChangeWallpaperList();

    if (downloadFiles.isNotEmpty) {
      final rand = Random().nextInt(downloadFiles.length);
      await WallpaperManager.setWallpaperFromFile(
          downloadFiles[rand], location);
      return true;
    }

    return false;
  }
}
