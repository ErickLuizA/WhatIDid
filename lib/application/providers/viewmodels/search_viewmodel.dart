import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/data/repositories/categories_repository.dart';
import 'package:whatidid/data/repositories/entries_repository.dart';
import 'package:whatidid/domain/models/category.dart';
import 'package:whatidid/domain/models/entrie.dart';

abstract class State {}

class InitialState extends State {}

class LoadingState extends State {}

class EmptyState extends State {}

class ErrorState extends State {}

class LoadedState<T> extends State {
  final List<T> result;

  LoadedState(this.result);
}

class SearchViewModel extends StateNotifier<State> {
  final EntriesRepository entriesRepository;
  final CategoriesRepository categoriesRepository;

  SearchViewModel({
    required this.entriesRepository,
    required this.categoriesRepository,
  }) : super(InitialState());

  void searchEntries(String title) async {
    state = LoadingState();

    try {
      final result = await entriesRepository.searchEntries(title);

      if (result.isEmpty) {
        state = EmptyState();
      } else {
        state = LoadedState<Entrie>(result);
      }
    } catch (e) {
      state = ErrorState();
    }
  }

  void searchCategories(String name) async {
    state = LoadingState();

    try {
      final result = await categoriesRepository.searchCategories(name);

      if (result.isEmpty) {
        state = EmptyState();
      } else {
        state = LoadedState<Category>(result);
      }
    } catch (e) {
      state = ErrorState();
    }
  }
}

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, State>((ref) {
  final entriesRepo = ref.watch(entriesRepositoryProvider);
  final categoriesRepo = ref.watch(categoriesRepositoryProvider);

  return SearchViewModel(
    categoriesRepository: categoriesRepo,
    entriesRepository: entriesRepo,
  );
});
