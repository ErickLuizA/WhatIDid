import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:whatidid/data/gateways/sembast_database.dart';
import 'package:whatidid/domain/models/entrie.dart';

const ENTRIES = 'ENTRIES';

class EntriesDao {
  final Database _database;

  EntriesDao(this._database);

  final _storeMap = intMapStoreFactory.store(ENTRIES);

  Future<void> insert(Map<String, dynamic> data) async {
    await _storeMap.add(_database, data);
  }

  Future<void> delete(int id) async {
    await _storeMap.delete(
      _database,
      finder: Finder(
        filter: Filter.byKey(id),
      ),
    );
  }

  Future<List<Entrie>> getAll(String category) async {
    final result = await _storeMap
        .query(finder: Finder(filter: Filter.equals('category', category)))
        .getSnapshots(_database);

    return result.map((e) {
      return Entrie.fromMap(e.value, id: e.key);
    }).toList();
  }
}

final entriesDaoProvider = Provider<EntriesDao>((ref) {
  final database = ref.watch(databaseProvider).database;

  return EntriesDao(database);
});
