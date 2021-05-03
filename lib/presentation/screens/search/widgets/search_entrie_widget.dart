import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatidid/application/providers/viewmodels/search_viewmodel.dart';
import 'package:whatidid/domain/models/category.dart';
import 'package:whatidid/domain/models/entrie.dart';
import 'package:whatidid/presentation/widgets/entrie_widget.dart';

class SearchEntrieWidget extends StatelessWidget {
  final String category;

  SearchEntrieWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search entrie',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onChanged: (String title) {
            if (title.isNotEmpty) {
              Future.delayed(Duration(milliseconds: 500), () {
                context
                    .read(searchViewModelProvider.notifier)
                    .searchEntries(title);
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
                content: Text("Error searching entrie"),
              ),
            );
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

            if (state is LoadedState<Entrie>) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final entrie = state.result[index];

                  return EntrieWidget(entrie);
                },
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
