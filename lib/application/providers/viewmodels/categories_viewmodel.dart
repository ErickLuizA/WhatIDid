import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/data/repositories/categories_repository.dart';
import 'package:whatidid/domain/models/category.dart';

abstract class State {}

class InitialState extends State {}

class LoadingState extends State {}

class EmptyState extends State {}

class ErrorState extends State {}

class LoadedState extends State {
  final List<Category> result;

  LoadedState(this.result);
}

class CategoriesViewModel extends StateNotifier<State> {
  final CategoriesRepository categoriesRepository;

  CategoriesViewModel(this.categoriesRepository) : super(InitialState());

  void getAll() async {
    state = LoadingState();

    try {
      final result = await categoriesRepository.getAll();

      if (result.isEmpty) {
        state = EmptyState();
      } else {
        state = LoadedState(result);
      }
    } catch (e) {
      state = ErrorState();
    }
  }
}

final categoriesViewModelProvider =
    StateNotifierProvider<CategoriesViewModel, State>((ref) {
  final repo = ref.watch(categoriesRepositoryProvider);

  return CategoriesViewModel(repo);
});
