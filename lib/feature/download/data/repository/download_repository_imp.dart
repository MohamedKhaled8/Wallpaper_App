import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wallapp/core/utils/networking/convert_url_to_file.dart';
import 'package:wallapp/feature/download/data/repository/download_repository.dart';


class DownloadRepositoryImp extends DownloadRepository {
  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  @override
  Future<File?> downloadFile(String url) async {
    return await Networking.convertUrlToFile(url);
  }

  @override
  Future<void> saveFileToExternalStorage(File file) async {
    await ImageGallerySaver.saveImage(await file.readAsBytes());
  }

  @override
  Future<List<File>> getDownloadedFiles() async {
    final appDir = await getApplicationDocumentsDirectory();
    final direct = Directory(appDir.path);
    final files = await direct.list().toList();
    return files.whereType<File>().toList();
  }

  @override
    @override
  Future<void> saveAutoChangeWallpaper(List<String> images) async {
    final prefs = await _sharedPreferences;
    await prefs.setStringList('autoChangeWallpaperKey', images);
  }

  @override
  @override
  Future<List<String>> getAutoChangeWallpaperList() async {
    final prefs = await _sharedPreferences;
    return prefs.getStringList('autoChangeWallpaperKey') ?? [];
  }
}
