class SearchModel {
  String wallpaperId;
  String categoryName;
  int dateCreated;
  String wallpaperImage;
  List<String> wallpaperTages;
  String authorId;

  SearchModel({
    required this.wallpaperId,
    required this.categoryName,
    required this.dateCreated,
    required this.wallpaperImage,
    required this.wallpaperTages,
    required this.authorId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'wallpaperId': wallpaperId,
      'categoryName': categoryName,
      'dateCreated': dateCreated,
      'wallpaperImage': wallpaperImage,
      'wallpaperTages': wallpaperTages,
      'authorId': authorId,
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    List<String> tagsList;
    if (map['wallpaperTages'] is String) {
      tagsList = (map['wallpaperTages'] as String).split(',');
    } else if (map['wallpaperTages'] is List) {
      tagsList = List<String>.from(map['wallpaperTages']);
    } else {
      tagsList = [];
    }

    return SearchModel(
      wallpaperId: map['wallpaperId'] as String,
      categoryName: map['categoryName'] as String,
      dateCreated: map['dateCreated'] != null ? map['dateCreated'] as int : 0,
      wallpaperImage: map['wallpaperImage'] as String,
      wallpaperTages: tagsList,
      authorId: map['authorId'] as String,
    );
  }
}
