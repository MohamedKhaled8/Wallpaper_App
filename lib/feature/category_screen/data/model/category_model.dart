import 'package:equatable/equatable.dart';

class CategorySModel extends Equatable {
  final String categoryName;
  final String categoryImage;
  final int dateCreated;

  const CategorySModel({
    required this.categoryName,
    required this.categoryImage,
    required this.dateCreated,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'dateCreated': dateCreated,
    };
  }

  factory CategorySModel.fromJson(Map<String, dynamic> map) {
    return CategorySModel(
      categoryName: map['categoryName'] as String,
      categoryImage: map['categoryImage'] as String,
      dateCreated: map['dateCreated'] != null ? map['dateCreated'] as int : 0,
    );
  }

  @override
  List<Object> get props => [categoryName, categoryImage, dateCreated];
}
