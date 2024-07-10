import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapp/core/utils/dependency/get_it.dart';
import 'package:wallapp/core/utils/error/dialoge_error.dart';
import 'package:wallapp/feature/wallpeper/model/wallpaper_model.dart';
import 'package:wallapp/feature/category_screen/data/model/category_model.dart';
import 'package:wallapp/feature/category_screen/data/repository/category_repository_category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepositoryCategory categoryRepository =
      getIt<CategoryRepositoryCategory>();

  CategoryCubit() : super(CategoryInitial());
  List<CategorySModel> _categories = [];
  List<CategorySModel> get categories => _categories;
  List<WallpaperModel> _categoryWallpaper = [];
  List<WallpaperModel> get categoryWallpaper => _categoryWallpaper;
  String message = "";
  String _categoryName = '';
  String get categoryName => _categoryName;
  String? _categoryImage;
  String? get categoryImage => _categoryImage;
  ViewState viewState = ViewState.idel;
  final _categoryRef = FirebaseFirestore.instance.collection("category");

  set categoryName(String value) {
    _categoryName = value;
    emit(CategoryInitial());
  }

  set categoryImage(String? value) {
    _categoryImage = value;
    emit(CategoryInitial());
  }

  Future<void> fetchCategory() async {
    viewState = ViewState.busy;
    emit(CategoryLoading());
    try {
      _categories = await categoryRepository.fetchCategories();
      viewState = ViewState.success;
      emit(CategoryLoaded(_categories));
    } catch (e) {
      message = e.toString();
      viewState = ViewState.error;
      emit(CategoryError(message));
    }
  }

  void getCategories(BuildContext context) async {
    await fetchCategory();
    // ignore: use_build_context_synchronously
    if (viewState == ViewState.error && Navigator.of(context).canPop()) {
      // ignore: use_build_context_synchronously
      showMessage(context, message);
    }
  }

  Future<void> saveCategory() async {
    viewState = ViewState.busy;
    emit(CategoryInitial());

    try {
      await categoryRepository.saveCategory(_categoryName, _categoryImage!);
      _categoryName = '';
      _categoryImage = null;
      viewState = ViewState.success;
      emit(CategoryInitial());
    } catch (e) {
      message = e.toString();
      viewState = ViewState.error;
      emit(CategoryInitial());
    }
  }

  Future<void> fechWallpaperByCategory(String categoryName) async {
    viewState = ViewState.busy;
    emit(CategoryInitial());
    try {
      _categoryWallpaper =
          await categoryRepository.fetchWallpapersByCategory(categoryName);
      _categoryWallpaper.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      viewState = ViewState.success;
      emit(CategoryInitial());
    } catch (e) {
      message = "Failed to fetch wallpapers by category: $e";
      viewState = ViewState.error;
      emit(CategoryInitial());
    }
  }
}
