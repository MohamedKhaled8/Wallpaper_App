abstract class SettingRepository {
  Future<void> setAutoChangeInterval(Duration interval);
  Future<int> getAutoChangeInterval();
  Future<void> getAppVersion();
  Future<void> setWallpaperLocation(int location);
  Future<int> getWallpaperLocation();
  Future<void> saveAutoChangeWallpaper(List<String> images);
  Future<List<String>> getAutoChangeWallpaperList();
  Future<bool> autoChangeWallpaper();
}
