import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/data/repositories/entries_repository.dart';
import 'package:whatidid/domain/models/entrie.dart';

abstract class State {}

class InitialState extends State {}

class LoadingState extends State {}

class EmptyState extends State {}

class ErrorState extends State {}

class LoadedState extends State {
  final List<Entrie> result;

  LoadedState(this.result);
}

class EntriesViewModel extends StateNotifier<State> {
  final EntriesRepository _entriesRepository;

  EntriesViewModel(this._entriesRepository) : super(InitialState());

  void getAll(String category) async {
    state = LoadingState();

    try {
      final result = await _entriesRepository.getEntries(category);

      if (result.isEmpty) {
        state = EmptyState();
      } else {
        state = LoadedState(result);
      }
    } catch (e) {
      state = ErrorState();
    }
  }

  Future<bool> delete(int id) async {
    try {
      await _entriesRepository.delete(id);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteAll(String category) async {
    return await _entriesRepository.deleteAll(category);
  }
}

final entriesViewModelProvider =
    StateNotifierProvider<EntriesViewModel, State>((ref) {
  final repo = ref.watch(entriesRepositoryProvider);

  return EntriesViewModel(repo);
});
