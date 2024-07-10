import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapp/core/utils/widgets/upload_file.dart';
import 'package:wallapp/feature/wallpeper/model/wallpaper_model.dart';

part 'add_wallpaper_state.dart';

class AddWallpaperCubit extends Cubit<AddWallpaperState> {
  final _wallpperRef = FirebaseFirestore.instance.collection("wallpaper");

  final User? _user = FirebaseAuth.instance.currentUser;
  String? _wallpeprImage;
  String? get wallpeprImage => _wallpeprImage;
  final List<String> _wallperTags = [];
  List<String> get wallpperTags => _wallperTags;
  String _selectedCategory = '';
  String get selectedCategory => _selectedCategory;
  ViewState viewState = ViewState.idel;
  String message = "";
  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  final List<WallpaperModel> _adminWallpaper = [];
  List<WallpaperModel> get adminWallpaper => _adminWallpaper;
  AddWallpaperCubit() : super(AddWallpaperInitial());

  set wallpeprImage(String? value) {
    _wallpeprImage = value;
    emit(AddWallpaperInitial());
  }

  void setWallpeperTages(String value) {
    final lwValue = value.toLowerCase();

    if (!wallpperTags.contains(lwValue)) {
      _wallperTags.add(lwValue);
    }
    emit(AddWallpaperInitial());
  }

  void removeWallpperTags(String value) {
    final lwValue = value.toLowerCase();

    if (!wallpperTags.contains(lwValue)) {
      _wallperTags.add(lwValue);
    }
    emit(AddWallpaperInitial());
  }

  set selectedCategory(String value) {
    _selectedCategory = value;
    emit(AddWallpaperInitial());
  }

  Future<void> saveWallpaper() async {
    viewState = ViewState.busy;
    emit(AddWallpaperInitial());
    try {
      final url = await uploadDocumentToServer(_wallpeprImage!);

      if (url.state == ViewState.error) {
        viewState = ViewState.error;
        message = url.fileUrl;
        emit(AddWallpaperInitial());
        return;
      }

      final payload = WallpaperModel(
        wallpaperId: '',
        categoryName: _selectedCategory.toLowerCase(),
        wallpaperImage: url.fileUrl,
        wallpaperTages: _wallperTags,
        dateCreated: DateTime.now().millisecondsSinceEpoch,
        author: Author(
          name: _user?.displayName ?? '', // Use ?. and ?? to handle null
          uid: _user?.uid ?? '',
          email: _user?.email ?? '',
        ),
        authorId: _user?.uid ?? '',
      );

      _wallpperRef.add(payload.toJson());

      _selectedCategory = '';
      _wallpeprImage = null;
      wallpperTags.clear();

      viewState = ViewState.success;
      emit(AddWallpaperInitial());
    } on FirebaseException catch (e) {
      message = e.code;
      viewState = ViewState.error;
      emit(AddWallpaperInitial());
    } catch (e) {
      message = e.toString();
      viewState = ViewState.error;
      emit(AddWallpaperInitial());
    }
  }

  Future<void> getAdminWallpepr() async {
    viewState = ViewState.busy;
    emit(AddWallpaperInitial());
    try {
      final result =
          await _wallpperRef.where('authorId', isEqualTo: _user!.uid).get();
      List<WallpaperModel> tempList = [];
      if (result.docs.isNotEmpty) {
        for (var i in result.docs) {
          final data = WallpaperModel.fromMap(i.data());
          data.wallpaperId = i.id;
          tempList.add(data);
        }
      }

      viewState = ViewState.success;
      emit(AddWallpaperInitial());
    } on FirebaseException catch (e) {
      message = e.code;
      viewState = ViewState.error;
      emit(AddWallpaperInitial());
    } catch (e) {
      message = e.toString();
      viewState = ViewState.error;
      emit(AddWallpaperInitial());
    }
  }
}
