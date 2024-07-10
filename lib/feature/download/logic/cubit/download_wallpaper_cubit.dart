import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import '../../../../core/utils/constant/my_string.dart';
import 'package:wallapp/core/utils/dependency/get_it.dart';
import 'package:wallapp/core/utils/config/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallapp/core/utils/error/dialoge_error.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallapp/feature/download/data/repository/download_repository_imp.dart';

part 'download_wallpaper_state.dart';

class DownloadWallpaperCubit extends Cubit<DownloadWallpaperState> {
  DownloadWallpaperCubit({
    required this.isLocalFile,
    required this.url,
  }) : super(DownloadWallpaperInitial());
  final DownloadRepositoryImp _repository = getIt<DownloadRepositoryImp>();

  ViewState viewState = ViewState.idel;
  String message = "";
  final bool isLocalFile;
  List<File> _downloadFile = [];
  List<File> get downloadFiIle => _downloadFile;
  final String url;
  final _appRef = SharedPreferences.getInstance();

  List<String> _autoChangeWallpaperList = [];
  List<String> get autoChangeWallpaperList => _autoChangeWallpaperList;

  void updateViewState(ViewState state, String? message) {
    viewState = state;
    this.message = message ?? '';
    emit(DownloadWallpaperInitial());
  }

  Future<void> handleError(String errorMessage, [Object? error]) async {
    updateViewState(ViewState.error, errorMessage);

    if (error is Exception) {
      appLogger('Error: $error');
    } else {
      appLogger('Non-Exception Error: $error');
    }
  }

  void showMessageIfNeeded(BuildContext context) {
    if (Navigator.canPop(context)) {
      showMessage(context, message, isError: viewState == ViewState.error);
    }
  }

  set setChangeWallpaper(String image) {
    if (_autoChangeWallpaperList.contains(image)) {
      _autoChangeWallpaperList.remove(image);
    } else {
      _autoChangeWallpaperList.add(image);
    }
    _repository.saveAutoChangeWallpaper(_autoChangeWallpaperList);
    emit(DownloadWallpaperInitial());
  }

  bool isFileValid(String path) {
    final file = File(path);
    return file.existsSync() && file.lengthSync() > 0;
  }

  Future<void> getAutoChangeWallpaperList() async {
    _autoChangeWallpaperList = await _repository.getAutoChangeWallpaperList();
    emit(DownloadWallpaperInitial());
  }

  Future<void> saveAutoChangeWallpaper(List<String> images) async {
    final value = await _appRef;
    value.setStringList(autoChangeWallpaperKey, images);
    getAutoChangeWallpaperList();
    emit(DownloadWallpaperInitial());
  }

  Future<void> downloadFile(String url, BuildContext context) async {
    viewState = ViewState.busy;
    emit(DownloadWallpaperInitial());

    try {
      final fileResponse = await _repository.downloadFile(url);
      if (fileResponse == null) {
        await handleError('Please try again');
        // ignore: use_build_context_synchronously
        showMessage(context, message, isError: false);
        return;
      }
      await _repository.saveFileToExternalStorage(fileResponse);

      updateViewState(ViewState.success,
          'File downloaded successfully: ${fileResponse.path}');
    } catch (e) {
      await handleError(
          'Error downloading file. Please try again', e as Exception?);
    }
  }

  Future<void> saveFileExternalStorage(File fileResponse) async {
    updateViewState(ViewState.busy, null);

    try {
      await _repository.saveFileToExternalStorage(fileResponse);

      updateViewState(ViewState.success, 'Wallpaper saved successfully');

      if (Platform.isIOS) {
        updateViewState(ViewState.success,
            "Wallpaper saved to your photos...\n\nUnfortunately, you can't directly set the wallpaper from the app. \n\nGo to your photos and set wallpaper manually");
      }
    } catch (e) {
      await handleError('Error saving wallpaper. Please try again.', e);
    }
  }

  Future<List<File>> getDownloadFiles() async {
    updateViewState(ViewState.busy, null);

    try {
      final fileList = await _repository.getDownloadedFiles();
      _downloadFile = fileList;
      updateViewState(ViewState.success, null);
      return fileList;
    } catch (e) {
      await handleError('Error getting downloaded files. Please try again.', e);
      return [];
    }
  }

  void downloadIosFile(BuildContext context) async {
    if (isLocalFile) {
      await _repository.saveFileToExternalStorage(File(url));
    } else {
      await downloadFile(url, context);
    }

    // ignore: use_build_context_synchronously
    showMessageIfNeeded(context);
  }

  Future<void> applyWallpaperSet(String imageUrl, int location) async {
    updateViewState(ViewState.busy, 'Applying wallpaper');

    String imagePath;

    if (imageUrl.startsWith('http')) {
      try {
        final fileResponse = await _repository.downloadFile(imageUrl);
        if (fileResponse == null) {
          await handleError('Error downloading file. Please try again.');
          return;
        }
        imagePath = fileResponse.path;
      } catch (e) {
        await handleError('Error downloading file. Please try again.', e);
        return;
      }
    } else {
      imagePath = imageUrl;
    }

    if (!File(imagePath).existsSync()) {
      appLogger("File does not exist: $imagePath");
      await handleError('File not found. Please try again.');
      return;
    }

    try {
      appLogger("Applying wallpaper from path: $imagePath");
      final result =
          await WallpaperManager.setWallpaperFromFile(imagePath, location);

      if (!result) {
        await handleError('Error applying wallpaper. Try again');
        return;
      }

      updateViewState(ViewState.success, 'Wallpaper applied successfully');
    } catch (e) {
      await handleError('Error applying wallpaper. Please try again.', e);
    }
  }

  Future<void> setWallpaperForHomeScreen(BuildContext context) async {
    await applyWallpaperSet(url, WallpaperManager.HOME_SCREEN);
    // ignore: use_build_context_synchronously
    showMessageIfNeeded(context);
  }

  Future<void> setWallpaperForLockScreen(BuildContext context) async {
    await applyWallpaperSet(url, WallpaperManager.LOCK_SCREEN);
    // ignore: use_build_context_synchronously
    showMessageIfNeeded(context);
  }

  Future<void> setWallpaperForBothScreens(BuildContext context) async {
    await applyWallpaperSet(url, WallpaperManager.BOTH_SCREEN);
    // ignore: use_build_context_synchronously
    showMessageIfNeeded(context);
  }
}
