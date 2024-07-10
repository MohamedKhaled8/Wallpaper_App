import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapp/core/utils/dependency/get_it.dart';
import 'package:wallapp/feature/favorite_screend.art/data/model/favorite_model.dart';
import 'package:wallapp/feature/favorite_screend.art/data/repository/favorite_repository_imp.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final FavoriteRepositoryImpl _favoriteRepository =
      getIt<FavoriteRepositoryImpl>();

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
    emit(FavoriteInitial());
  }

  List<FavoriteModel> _favoriteList = [];
  List<FavoriteModel> get favoriteList => _favoriteList;
  ViewState viewState = ViewState.idel;
  String message = '';

  Future<void> addToFavorite(FavoriteModel data) async {
    _isFavorite = true;
    emit(FavoriteLoading());
    await _favoriteRepository.addToFavorite(data);
    emit(FavoriteSuccess());
  }

  Future<void> deleteFromFavorite(String id) async {
    _isFavorite = false;
    emit(FavoriteLoading());
    await _favoriteRepository.deleteFromFavorite(id);
    emit(FavoriteSuccess());
  }

  Future<void> retrieveFavoriteById(String id) async {
    emit(FavoriteLoading());
    final favorite = await _favoriteRepository.retrieveFavoriteById(id);
    _isFavorite = favorite != null;
    emit(FavoriteSuccess());
  }

  Future<void> retrieveFavorite() async {
    viewState = ViewState.busy;
    emit(FavoriteLoading());
    try {
      _favoriteList = await _favoriteRepository.retrieveFavorites();
      viewState = ViewState.success;
      emit(FavoriteSuccess());
    } on FirebaseException catch (e) {
      message = e.code;
      viewState = ViewState.error;
      emit(FavoriteInitial());
    } catch (e) {
      message = e.toString();
      viewState = ViewState.error;
      emit(FavoriteError(message));
    }
  }
}
