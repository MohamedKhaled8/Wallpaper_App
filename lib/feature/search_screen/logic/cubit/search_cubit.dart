import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapp/feature/search_screen/data/model/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  int selectedIndex = 0;

  final _SearchRef = FirebaseFirestore.instance.collection('wallpaper');

  ViewState viewState = ViewState.idel;

  String message = "";
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  List<String> sampleSearch = [
    "love",
    "animal",
    "wallpaper",
    "dark ",
    "natural"
  ];
  List<SearchModel> _searchList = [];
  List<SearchModel> get searchList => _searchList;

  set searchQuery(String value) {
    _searchQuery = value;
    emit(SearchInitial());
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    emit(SearchInitial());
  }

  Future<void> search(String query) async {
    final seQuery = query.toLowerCase();
    viewState = ViewState.busy;
    emit(SearchInitial());
    try {
      final result = await _SearchRef.get();

      List<SearchModel> tempList = [];

      if (result.docs.isNotEmpty) {
        for (var i in result.docs) {
          final data = SearchModel.fromMap(i.data());
          data.wallpaperId = i.id;
          if (data.categoryName.toLowerCase().contains(seQuery) ||
              data.wallpaperTages.contains(seQuery)) {
            tempList.add(data);
          }
        }
      } else {
        tempList = [];
      }

      _searchList = tempList;
      viewState = ViewState.success;
      emit(SearchInitial());
    } on FirebaseException catch (e) {
      message = e.code;
      viewState = ViewState.error;
      emit(SearchInitial());
    } catch (e) {
      message = e.toString();
      viewState = ViewState.error;
      emit(SearchInitial());
    }
  }

  @override
  Future<void> close() {
    _searchController.dispose();
    return super.close();
  }
}
