import 'package:flutter/material.dart';
import 'package:whatidid/domain/models/category.dart';

class CategoryScreen extends StatelessWidget {
  final Category category;

  CategoryScreen(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
