import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable {
  final String id;
  final String wallpaperImage;
  final int dateCreated;

  const FavoriteModel({
    required this.id,
    required this.wallpaperImage,
    required this.dateCreated,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'wallpaperImage': wallpaperImage,
      'dateCreated': dateCreated,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as String,
      wallpaperImage: map['wallpaperImage'] as String,
      dateCreated: map['dateCreated'] as int,
    );
  }

  @override
  List<Object?> get props => [id, wallpaperImage, dateCreated];
}
