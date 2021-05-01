import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Entrie extends Equatable {
  int? id;
  final String title;
  final String? image;
  final DateTime dateTime;
  final String content;
  final String category;

  Entrie({
    this.id,
    required this.title,
    required this.image,
    required this.dateTime,
    required this.content,
    required this.category,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        dateTime,
        content,
        category,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'dateTime': dateTime.toString(),
      'content': content,
      'category': category,
    };
  }

  factory Entrie.fromMap(Map<String, dynamic> map, {int? id}) {
    return Entrie(
      id: id ?? map['id'],
      image: map['image'],
      title: map['title'],
      dateTime: DateTime.parse(map['dateTime']),
      content: map['content'],
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Entrie.fromJson(String source) => Entrie.fromMap(json.decode(source));
}
