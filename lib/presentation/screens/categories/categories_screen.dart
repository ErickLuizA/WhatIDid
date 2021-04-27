import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/application/providers/viewmodels/categories_viewmodel.dart'
    hide State;
import 'package:whatidid/presentation/widgets/empty_widget.dart';

import 'widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();

    context.read(categoriesViewModelProvider.notifier).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: categoriesViewModelProvider,
      onChange: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error loading categories"),
            ),
          );
        }
      },
      child: Consumer(
        builder: (context, watch, child) {
          final state = watch(categoriesViewModelProvider);

          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is EmptyState) {
            return EmptyWidget("category");
          }

          if (state is LoadedState) {
            return GridView.count(
              crossAxisCount: 2,
              semanticChildCount: state.result.length,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: state.result.map((e) => CategoryWidget(e)).toList(),
            );
          }

          return Container();
        },
      ),
    );
  }
}
