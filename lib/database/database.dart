import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  const databaseName = 'bytebank.db';
  final String path = join(await getDatabasesPath(), databaseName);
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    },
    version: 1,
  );
}
