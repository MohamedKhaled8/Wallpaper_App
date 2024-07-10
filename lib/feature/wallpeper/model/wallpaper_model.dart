class WallpaperModel {
  String wallpaperId;
  String categoryName;
  int dateCreated;
  String wallpaperImage;
  List<String> wallpaperTages;
  String authorId;
  Author author;

  WallpaperModel({
    required this.wallpaperId,
    required this.categoryName,
    required this.dateCreated,
    required this.wallpaperImage,
    required this.wallpaperTages,
    required this.authorId,
    required this.author,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'wallpaperId': wallpaperId,
      'categoryName': categoryName,
      'dateCreated': dateCreated,
      'wallpaperImage': wallpaperImage,
      'wallpaperTages': wallpaperTages,
      'authorId': authorId,
      'author': author.toJson(),
    };
  }

  factory WallpaperModel.fromMap(Map<String, dynamic> map) {
    List<String> tagsList;
    if (map['wallpaperTages'] is String) {
      tagsList = (map['wallpaperTages'] as String).split(',');
    } else if (map['wallpaperTages'] is List) {
      tagsList = List<String>.from(map['wallpaperTages']);
    } else {
      tagsList = [];
    }

    return WallpaperModel(
      wallpaperId: map['wallpaperId'] as String,
      categoryName: map['categoryName'] as String,
      dateCreated: map['dateCreated'] != null ? map['dateCreated'] as int : 0,
      wallpaperImage: map['wallpaperImage'] as String,
      wallpaperTages: tagsList,
      authorId: map['authorId'] as String,
      author: Author.fromJson(map['author'] as Map<String, dynamic>),
    );
  }
}

class Author {
  String name;
  String uid;
  String email;

  Author({
    required this.name,
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'email': email,
    };
  }

  factory Author.fromJson(Map<String, dynamic> map) {
    return Author(
      name: map['name'] as String,
      uid: map['uid'] as String,
      email: map['email'] as String,
    );
  }
}
