import 'package:flutter/material.dart';
import 'package:whatidid/presentation/screens/create/widgets/create_category_widget.dart';
import 'package:whatidid/presentation/screens/create/widgets/create_entrie_widget.dart';

class CreateScreen extends StatelessWidget {
  final String? category;

  const CreateScreen({
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return CreateCategoryWidget();
    } else {
      return CreateEntrieWidget(category!);
    }
  }
}
