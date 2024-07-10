import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapp/feature/favorite_screend.art/data/model/favorite_model.dart';

class FirebaseFavoriteDataSource {
  final CollectionReference _favoriteRef =
      FirebaseFirestore.instance.collection('favorites');
  final User? _user = FirebaseAuth.instance.currentUser;

  Future<void> addFavorite(FavoriteModel data) async {
    await _favoriteRef.doc(_user?.uid).collection('data').add(data.toJson());
  }

  Future<void> deleteFavorite(String id) async {
    final result = await _favoriteRef
        .doc(_user?.uid)
        .collection('data')
        .where('id', isEqualTo: id)
        .get();

    if (result.docs.isNotEmpty) {
      for (var i in result.docs) {
        await _favoriteRef
            .doc(_user?.uid)
            .collection('data')
            .doc(i.id)
            .delete();
      }
    }
  }

  Future<FavoriteModel?> getFavoriteById(String id) async {
    final result = await _favoriteRef
        .doc(_user?.uid)
        .collection('data')
        .where('id', isEqualTo: id)
        .get();

    if (result.docs.isNotEmpty) {
      return FavoriteModel.fromJson(result.docs.first.data());
    }

    return null;
  }

  Future<List<FavoriteModel>> getFavorites() async {
    final result = await _favoriteRef.doc(_user?.uid).collection('data').get();

    List<FavoriteModel> tempList = [];

    if (result.docs.isNotEmpty) {
      for (var i in result.docs) {
        tempList.add(FavoriteModel.fromJson(i.data()));
      }
    }

    return tempList;
  }
}
