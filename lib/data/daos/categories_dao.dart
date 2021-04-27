import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:whatidid/data/gateways/sembast_database.dart';
import 'package:whatidid/domain/models/category.dart';

const CATEGORIES = 'CATEGORIES';

class CategoriesDao {
  final Database _database;

  CategoriesDao(this._database);

  final _storeMap = intMapStoreFactory.store(CATEGORIES);

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

  Future<List<Category>> getAll() async {
    final snapshots = await _storeMap.query().getSnapshots(_database);

    return snapshots.map((e) {
      return Category.fromMap(e.value, id: e.key);
    }).toList();
  }
}

final categoriesDaoProvider = Provider<CategoriesDao>((ref) {
  final database = ref.watch(databaseProvider).database;

  return CategoriesDao(database);
});
