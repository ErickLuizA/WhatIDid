import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/data/daos/entries_dao.dart';
import 'package:whatidid/domain/models/entrie.dart';

class EntriesRepository {
  final EntriesDao _entriesDao;

  EntriesRepository(this._entriesDao);

  Future<void> insert(Map<String, dynamic> data) async {
    return await _entriesDao.insert(data);
  }

  Future<List<Entrie>> getAll(String category) async {
    return await _entriesDao.getAll(category);
  }
}

final entriesRepositoryProvider = Provider<EntriesRepository>((ref) {
  final db = ref.watch(entriesDaoProvider);

  return EntriesRepository(db);
});
