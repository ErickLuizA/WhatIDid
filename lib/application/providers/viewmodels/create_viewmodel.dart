import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/data/repositories/categories_repository.dart';
import 'package:whatidid/data/repositories/entries_repository.dart';
import 'package:whatidid/domain/models/category.dart';

class CreateViewModel {
  final CategoriesRepository categoriesRepository;
  final EntriesRepository entriesRepository;

  CreateViewModel({
    required this.categoriesRepository,
    required this.entriesRepository,
  });

  Future<List<Category>> getCategories() async {
    return await categoriesRepository.getAll();
  }

  Future<bool> insert(Map<String, dynamic> data) async {
    try {
      await categoriesRepository.insert(data);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertEntrie(Map<String, dynamic> data) async {
    try {
      await entriesRepository.insert(data);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      await categoriesRepository.delete(id);

      return true;
    } catch (e) {
      return false;
    }
  }
}

final createViewModelProvider = Provider<CreateViewModel>((ref) {
  final repo = ref.read(categoriesRepositoryProvider);
  final entrieRepo = ref.read(entriesRepositoryProvider);

  return CreateViewModel(
      categoriesRepository: repo, entriesRepository: entrieRepo);
});
