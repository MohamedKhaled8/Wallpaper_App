import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapp/core/utils/config/app_logger.dart';
import 'package:wallapp/feature/wallpeper/model/wallpaper_model.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallapp/feature/home/data/repository/home_wallpaper_repository.dart';

class WallpaperRepository extends HomeWallpaprRepository  {
  final CollectionReference _wallpaperRef =
      FirebaseFirestore.instance.collection('wallpaper');

  @override
  Future<List<WallpaperModel>> fetchRecentWallpapers() async {
    try {
      final result = await _wallpaperRef.get();
      List<WallpaperModel> wallpapers = [];
      for (var doc in result.docs) {
        final data = WallpaperModel.fromMap(doc.data() as Map<String, dynamic>);
        data.wallpaperId = doc.id;
        wallpapers.add(data);
      }
      return wallpapers;
    } catch (e) {
      appLogger("Error fetching recent wallpapers: $e");
      throw Exception("Failed to fetch recent wallpapers");
    }
  }

  @override
  Future<List<WallpaperModel>> fetchWallpapersByCategory(
      String categoryName) async {
    try {
      final result = await _wallpaperRef
          .where('categoryName', isEqualTo: categoryName.toLowerCase())
          .get();
      List<WallpaperModel> wallpapers = [];
      for (var doc in result.docs) {
        final data = WallpaperModel.fromMap(doc.data() as Map<String, dynamic>);
        data.wallpaperId = doc.id;
        wallpapers.add(data);
      }
      return wallpapers;
    } catch (e) {
      appLogger("Error fetching wallpapers by category: $e");
      throw Exception("Failed to fetch wallpapers by category");
    }
  }

  @override
  Future<void> applyWallpaper(String image, int location) async {
    try {
      if (!File(image).existsSync()) {
        throw Exception("File not found: $image");
      }

      appLogger("Applying wallpaper from path: $image");
      final result =
          await WallpaperManager.setWallpaperFromFile(image, location);

      if (!result) {
        throw Exception("Error applying wallpaper");
      }

      appLogger("Wallpaper applied successfully");
    } catch (e) {
      appLogger("Error applying wallpaper: $e");
      throw Exception("Failed to apply wallpaper");
    }
  }
}
