import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/dependency/get_it.dart';
import 'package:wallapp/feature/wallpeper/model/wallpaper_model.dart';
import 'package:wallapp/feature/home/data/repository/home_allpaper_repository.dart';

part 'home_wallpaper_state.dart';

class HomeWallpaperCubit extends Cubit<HomeWallpaperState> {
  HomeWallpaperCubit() : super(HomeWallpaperInitial());
  final WallpaperRepository _repository = getIt<WallpaperRepository>();

  List<WallpaperModel> _recentWallpaper = [];
  List<WallpaperModel> get recentWallpaper => _recentWallpaper;

  List<WallpaperModel> _categoryWallpaper = [];
  List<WallpaperModel> get categoryWallpaper => _categoryWallpaper;

  ViewState viewState = ViewState.idel;
  String message = "";

  Future<void> applyWallpaper(String image, int location) async {
    viewState = ViewState.busy;
    message = 'Applying wallpaper';
    emit(HomeWallpaperInitial());

    try {
      await _repository.applyWallpaper(image, location);
      viewState = ViewState.success;
      message = "Wallpaper applied successfully";
      emit(HomeWallpaperInitial());
    } catch (e) {
      message = "Failed to apply wallpaper: $e";
      viewState = ViewState.error;
      emit(HomeWallpaperInitial());
    }
  }

  Future<void> fetchRecentWallpaper() async {
    viewState = ViewState.busy;
    emit(HomeWallpaperInitial());
    try {
      _recentWallpaper = await _repository.fetchRecentWallpapers();
      _recentWallpaper.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      viewState = ViewState.success;
      emit(HomeWallpaperInitial());
    } catch (e) {
      message = "Failed to fetch recent wallpapers: $e";
      viewState = ViewState.error;
      emit(HomeWallpaperInitial());
    }
  }

  
}
