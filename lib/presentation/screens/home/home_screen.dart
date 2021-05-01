import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatidid/application/providers/viewmodels/entries_viewmodel.dart'
    hide State;
import 'package:whatidid/presentation/widgets/empty_widget.dart';

import 'widgets/entrie_widget.dart';

class HomeScreen extends StatefulWidget {
  final String category;

  const HomeScreen(this.category);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read(entriesViewModelProvider.notifier).getAll(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: entriesViewModelProvider,
      onChange: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error loading entries"),
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
    );
  }
}
