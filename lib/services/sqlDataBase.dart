import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:examen/models/type_article.dart';

class CruddataBase {
  late Database _database;
  Future<void> openDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'articles.db');
    _database = await openDatabase(path, version: 1, onCreate: _CreateDb);
  }

  Future<void> _CreateDb(Database db, int version) async {
    await db.execute('''
CREATE TABLE type_article (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        description TEXT NOT NULL
      )
''');
  }

  Future<int> insertTypeArticle(TypeArticle typeArticle) async {
    await openDb();
    return await _database.insert("type_article", typeArticle.toMap());
  }

  Future<void> updateTypeArticle(TypeArticle typeArticle) async {
    await _database.update("type_article", typeArticle.toMap(),
        where: 'id=?', whereArgs: [typeArticle.id]);
  }

  Future<void> deleteTypeArticle(int id) async {
    await _database.delete("type_article", where: 'id=?', whereArgs: [id]);
  }

  Future<List<TypeArticle>> getAllTypeArticles() async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database.query('Type_article');

    return List.generate(maps.length, (i) {
      return TypeArticle(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        description: maps[i]['description'],
      );
    });
  }

  Future <TypeArticle?> getArticleWithId(int id) async {
    await openDb();
    final List<Map<String,dynamic>>
    maps=await _database.query("type_article",
    where: 'id=?',
    whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TypeArticle(
        id: maps[0]['id'],
        nom: maps[0]['nom'],
        description: maps[0]['description']);
    } else {
      return null;
    }
  }
}
