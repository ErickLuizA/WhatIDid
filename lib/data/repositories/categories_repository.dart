import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/data/daos/categories_dao.dart';

import 'package:whatidid/domain/models/category.dart';

class CategoriesRepository {
  final CategoriesDao _categoriesDao;

  CategoriesRepository(this._categoriesDao);

  Future<void> insert(Map<String, dynamic> data) async {
    return await _categoriesDao.insert(data);
  }

  Future<void> delete(int id) async {
    return await _categoriesDao.delete(id);
  }

  Future<List<Category>> getAll() async {
    return await _categoriesDao.getAll();
  }

  Future<List<Category>> searchCategories(String name) async {
    return await _categoriesDao.searchCategories(name);
  }
}

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  final db = ref.watch(categoriesDaoProvider);

  return CategoriesRepository(db);
});
