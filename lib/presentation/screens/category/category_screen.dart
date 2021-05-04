import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/application/providers/viewmodels/categories_viewmodel.dart'
    hide State, ErrorState, LoadedState, LoadingState, EmptyState;
import 'package:whatidid/application/providers/viewmodels/entries_viewmodel.dart'
    hide State;
import 'package:whatidid/domain/models/category.dart';
import 'package:whatidid/presentation/app_localizations.dart';
import 'package:whatidid/presentation/widgets/empty_widget.dart';
import 'package:whatidid/presentation/widgets/entrie_widget.dart';
import 'package:whatidid/presentation/widgets/fab_widget.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  CategoryScreen(this.category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context
          .read(entriesViewModelProvider.notifier)
          .getAll(widget.category.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          PopupMenuButton(
            onSelected: (String selected) async {
              if (selected == "delete") {
                final res = await context
                    .read(categoriesViewModelProvider.notifier)
                    .delete(widget.category.id!);

                if (res) {
                  if (Navigator.canPop(context)) {
                    await context
                        .read(entriesViewModelProvider.notifier)
                        .deleteAll(widget.category.name);

                    context.read(categoriesViewModelProvider.notifier).getAll();

                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)
                          .translate("error_deleting_entrie")),
                    ),
                  );
                }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "delete",
                  child: Text(AppLocalizations.of(context).translate("delete")),
                ),
              ];
            },
          ),
        ],
      ),
      body: ProviderListener(
        provider: entriesViewModelProvider,
        onChange: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)
                    .translate("error_loading_entries")),
              ),
            );
          }
        },
        child: Consumer(
          builder: (context, watch, child) {
            final state = watch(entriesViewModelProvider);

            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is EmptyState) {
              return EmptyWidget("entrie");
            }

            if (state is LoadedState) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: ListView.builder(
                  itemCount: state.result.length,
                  itemBuilder: (context, index) {
                    final entrie = state.result[index];

                    return EntrieWidget(entrie);
                  },
                ),
              );
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FabWidget(widget.category.name),
    );
  }
}
