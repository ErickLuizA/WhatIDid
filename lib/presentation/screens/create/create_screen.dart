import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  final String? category;

  const CreateScreen({
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    print(category);
    // if category is null
    // render create category
    // else render create entrie
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
