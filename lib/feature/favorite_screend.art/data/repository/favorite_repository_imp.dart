import 'package:wallapp/core/utils/firebase/firebase_favorite_data_source.dart';
import 'package:wallapp/feature/favorite_screend.art/data/model/favorite_model.dart';
import 'package:wallapp/feature/favorite_screend.art/data/repository/favorite_repository.dart';


class FavoriteRepositoryImpl implements FavoriteRepository {
  final FirebaseFavoriteDataSource _firebaseFavoriteDataSource;

  FavoriteRepositoryImpl(this._firebaseFavoriteDataSource);

  @override
  Future<void> addToFavorite(FavoriteModel data) async {
    await _firebaseFavoriteDataSource.addFavorite(data);
  }

  @override
  Future<void> deleteFromFavorite(String id) async {
    await _firebaseFavoriteDataSource.deleteFavorite(id);
  }

  @override
  Future<FavoriteModel?> retrieveFavoriteById(String id) async {
    return await _firebaseFavoriteDataSource.getFavoriteById(id);
  }

  @override
  Future<List<FavoriteModel>> retrieveFavorites() async {
    return await _firebaseFavoriteDataSource.getFavorites();
  }
}