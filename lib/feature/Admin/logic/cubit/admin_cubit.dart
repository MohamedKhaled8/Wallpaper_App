import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapp/feature/wallpeper/model/wallpaper_model.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  String message = "";
  final _wallpperRef = FirebaseFirestore.instance.collection("wallpaper");

  final User? _user = FirebaseAuth.instance.currentUser;
  List<WallpaperModel> _adminWallpaper = [];
  List<WallpaperModel> get adminWallpaper => _adminWallpaper;
  final _categoryRef = FirebaseFirestore.instance.collection("category");

  AdminCubit() : super(AdminInitial());

  List<String> homeActionList = ["Add Category ", "Add Wallpeper"];

  ViewState viewState = ViewState.idel;

  Future<void> getAdminWallpepr() async {
    emit(AdminLoading());

    viewState = ViewState.busy;
    emit(AdminInitial());
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

      _adminWallpaper = tempList;
      _adminWallpaper.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      viewState = ViewState.success;
      emit(AdminLoaded());
    } on FirebaseException catch (e) {
      message = e.code;
      viewState = ViewState.error;
      emit(AdminInitial());
      debugPrint("FirebaseException: $e");
    } catch (e) {
      message = e.toString();
      viewState = ViewState.error;

      emit(AdminError(e.toString()));
    }
  }
}
