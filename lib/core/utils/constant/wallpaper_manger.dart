import 'package:flutter/services.dart';

class WallpaperManger {
  WallpaperManger._();

  static const MethodChannel _channel =
      MethodChannel('flutter_wallpaper_maanger');

  static int HOME_SCREEN = 1;
  static int LOCK_SCREEN = 2;
  static int BOTH_SCREEN = 3;

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');

    return version;
  }

  static Future<bool> setWallpaperFromFile(
      String filePath, int wallpaperLocation) async {
    final int result = await _channel.invokeMethod('setWallpaperFromFile', {
      'filePath': filePath,
      'wallpaperLocation': wallpaperLocation,
    });
    return result > 0 ? true : false;
  }

  static Future<bool> clearWallpaper() async {
    final bool result = await _channel.invokeMethod('clearWallpaper');
    return result;
  }

  static Future<int> getDesiredMinimumWidth() async {
    final int result =
        await _channel.invokeMethod('getDesiredMinimumWidth');
    return result;
  }

  static Future<int> getDesiredMinimumHigth() async {
    final int result =
        await _channel.invokeMethod('getDesiredMinimumHigth');
    return result;
  }
}
