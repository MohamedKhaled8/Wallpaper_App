import 'package:wallapp/feature/favorite_screend.art/data/model/favorite_model.dart';

abstract class FavoriteRepository {
  Future<void> addToFavorite(FavoriteModel data);
  Future<void> deleteFromFavorite(String id);
  Future<FavoriteModel?> retrieveFavoriteById(String id);
  Future<List<FavoriteModel>> retrieveFavorites();
}
