import '../../../../core/utils/config/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapp/core/utils/config/app_logger.dart';
import 'package:wallapp/core/utils/widgets/upload_file.dart';
import 'package:wallapp/core/utils/model/category_model.dart';
import 'package:wallapp/feature/wallpeper/model/wallpaper_model.dart';
import 'package:wallapp/feature/category_screen/data/model/category_model.dart';
import 'package:wallapp/feature/category_screen/data/repository/category_repository.dart';





class CategoryRepositoryCategory extends CategoryRepository {
 final CollectionReference _categoryRef = FirebaseFirestore.instance.collection("category");
 final CollectionReference _wallpaperRef =
      FirebaseFirestore.instance.collection('wallpaper');
  @override
  Future<List<CategorySModel>> fetchCategories() async {
    final result = await _categoryRef.get();
    List<CategorySModel> tempList = [];
    if (result.docs.isNotEmpty) {
      for (var i in result.docs) {
        tempList.add(CategorySModel.fromJson(i.data() as Map<String, dynamic>));
      }
    }
    return tempList;
  }

  Future<void> saveCategory(String categoryName, String categoryImage) async {
    final url = await uploadDocumentToServer(categoryImage);
    if (url.state == ViewState.error) {
      throw Exception(url.fileUrl);
    }
    final payload = CategoryModel(
        categoryName: categoryName,
        categoryImage: url.fileUrl,
        dateCreate: DateTime.now().millisecondsSinceEpoch);
    await _categoryRef.add(payload.toMap());
  }

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

}
