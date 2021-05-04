import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  int? id;
  final String? image;
  final String name;

  Category({
    this.id,
    required this.image,
    required this.name,
  });

  @override
  List<Object?> get props => [id, image, name];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map, {int? id}) {
    return Category(
      id: id ?? map['id'],
      image: map['image'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
