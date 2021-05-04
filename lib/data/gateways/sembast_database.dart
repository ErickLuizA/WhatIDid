import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

const _schemaVersion = 1;
const _dbName = 'whatidid_db.db';

class DatabaseHelper {
  late Database database;

  Future<void> openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();

    await dir.create(recursive: true);

    final dbPath = path.join(dir.path, _dbName);

    database = await databaseFactoryIo.openDatabase(
      dbPath,
      version: _schemaVersion,
    );
  }
}

final databaseProvider = Provider((ref) => DatabaseHelper());
