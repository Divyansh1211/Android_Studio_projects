//Performing Json Serialisation to convert the Json file to mapped Json

import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  final String title;
  final String authors;
  final String coverImageUrl;

  Book({required this.title, required this.authors, required this.coverImageUrl});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}