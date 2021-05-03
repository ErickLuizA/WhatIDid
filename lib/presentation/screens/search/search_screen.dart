import 'package:flutter/material.dart';

import 'widgets/search_category_widget.dart';
import 'widgets/search_entrie_widget.dart';

class SearchScreen extends StatelessWidget {
  final String? category;

  const SearchScreen({
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return SearchCategoryWidget();
    } else {
      return SearchEntrieWidget(category!);
    }
  }
}
