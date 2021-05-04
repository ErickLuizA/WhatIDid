import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatidid/application/providers/viewmodels/search_viewmodel.dart';
import 'package:whatidid/domain/models/category.dart';
import 'package:whatidid/domain/models/entrie.dart';
import 'package:whatidid/presentation/app_localizations.dart';
import 'package:whatidid/presentation/screens/categories/widgets/category_widget.dart';

class SearchCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).translate('search_category'),
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onChanged: (String name) {
            if (name.isNotEmpty) {
              Future.delayed(Duration(milliseconds: 500), () {
                context
                    .read(searchViewModelProvider.notifier)
                    .searchCategories(name);
              });
            }
          },
        ),
      ),
      body: ProviderListener(
        provider: searchViewModelProvider,
        onChange: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)
                    .translate('error_search_category')),
              ),
            );
          }

          if (state is LoadedState<Entrie>) {
            context.read(searchViewModelProvider.notifier).searchCategories('');
          }
        },
        child: Consumer(
          builder: (context, watch, child) {
            final state = watch(searchViewModelProvider);

            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LoadedState<Category>) {
              return GridView.count(
                crossAxisCount: state.result.length,
                children: state.result.map((e) => CategoryWidget(e)).toList(),
              );
            }

            return Center(
              child: SvgPicture.asset(
                'assets/images/empty.svg',
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
              ),
            );
          },
        ),
      ),
    );
  }
}
