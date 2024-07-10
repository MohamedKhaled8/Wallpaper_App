import 'dart:convert';

class CategoryModel {
  String categoryName;
  String categoryImage;
  int dateCreate;
  CategoryModel({
    required this.categoryName,
    required this.categoryImage,
    required this.dateCreate,
  });

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'dateCreate': dateCreate,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryName: map['categoryName'] as String,
      categoryImage: map['categoryImage'] as String,
      dateCreate: map['dateCreate'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(categoryName: $categoryName, categoryImage: $categoryImage, dateCreate: $dateCreate)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.categoryName == categoryName &&
      other.categoryImage == categoryImage &&
      other.dateCreate == dateCreate;
  }

  @override
  int get hashCode => categoryName.hashCode ^ categoryImage.hashCode ^ dateCreate.hashCode;
}
