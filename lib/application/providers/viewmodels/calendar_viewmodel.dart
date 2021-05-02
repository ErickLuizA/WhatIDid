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

class CalendarViewModel extends StateNotifier<State> {
  final EntriesRepository _entriesRepository;

  CalendarViewModel(
    this._entriesRepository,
  ) : super(InitialState());

  void getMonthAll(DateTime dateTime) async {
    state = LoadingState();

    try {
      final result = await _entriesRepository.getMonthAll(dateTime);

      if (result.isEmpty) {
        state = EmptyState();
      } else {
        state = LoadedState(result);
      }
    } catch (e) {
      state = ErrorState();
    }
  }

  void getDayAll(DateTime dateTime) async {
    state = LoadingState();

    try {
      final result = await _entriesRepository.getDayAll(dateTime);

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

final calendarViewModelProvider =
    StateNotifierProvider<CalendarViewModel, State>((ref) {
  final repo = ref.watch(entriesRepositoryProvider);

  return CalendarViewModel(repo);
});
