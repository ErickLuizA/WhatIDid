import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String? category;

  const SearchScreen({
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    print(category);

    // if category is null
    // render search categories
    // else render search category
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
