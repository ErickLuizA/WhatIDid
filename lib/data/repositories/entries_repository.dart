import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/data/daos/entries_dao.dart';
import 'package:whatidid/domain/models/entrie.dart';

class EntriesRepository {
  final EntriesDao _entriesDao;

  EntriesRepository(this._entriesDao);

  Future<void> insert(Map<String, dynamic> data) async {
    return await _entriesDao.insert(data);
  }

  Future<void> delete(int id) async {
    return await _entriesDao.delete(id);
  }

  Future<void> deleteAll(String category) async {
    return await _entriesDao.deleteAll(category);
  }

  Future<List<Entrie>> getEntries(String category) async {
    return await _entriesDao.getEntries(category);
  }

  Future<List<Entrie>> getMonthAll(DateTime dateTime) async {
    return await _entriesDao.getMonthAll(dateTime);
  }

  Future<List<Entrie>> getDayAll(DateTime dateTime) async {
    return await _entriesDao.getDayAll(dateTime);
  }
}

final entriesRepositoryProvider = Provider<EntriesRepository>((ref) {
  final db = ref.watch(entriesDaoProvider);

  return EntriesRepository(db);
});
