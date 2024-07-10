import 'dart:io';

abstract class DownloadRepository {
Future<File?> downloadFile(String url);
  Future<void> saveFileToExternalStorage(File file);
  Future<List<File>> getDownloadedFiles();
  Future<void> saveAutoChangeWallpaper(List<String> images);
  Future<List<String>> getAutoChangeWallpaperList();
  // wallpaper_repository.dar

}
