import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/data/daos/categories_dao.dart';

import 'package:whatidid/domain/models/category.dart';

class CategoriesRepository {
  final CategoriesDao _categoriesDao;

  CategoriesRepository(this._categoriesDao);

  Future<List<Category>> getAll() async {
    return await _categoriesDao.getAll();
  }
}

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  final db = ref.watch(categoriesDaoProvider);

  return CategoriesRepository(db);
});
