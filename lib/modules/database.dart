import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DataHelper {
  static Future<sql.Database> database() async {
    final databasesPath = await sql.getDatabasesPath();
    final pathToDatabase = path.join(databasesPath, 'imagedb.db');
    return sql.openDatabase(
      pathToDatabase,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_image(id TEXT PRIMARY KEY, title TEXT, image TEXT, story TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object?> data) async {
    final db = await DataHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DataHelper.database();
    return db.query(table);
  }

  static Future<void> update(
      String table, String id, Map<String, Object?> data) async {
    final db = await DataHelper.database();
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> delete(String table, String id) async {
    final db = await DataHelper.database();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
