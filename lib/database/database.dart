import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseQuiz {
  static final BaseQuiz instance = BaseQuiz._init();
  static Database? _database;
  BaseQuiz._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quiz.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final path = join(await getDatabasesPath(), fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Table utilisateurs
    await db.execute('''
CREATE TABLE utilisateurs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE NOT NULL,
  mot_de_passe TEXT NOT NULL
)
''');

    // Table scores
    await db.execute('''
CREATE TABLE scores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT NOT NULL,
  score INTEGER NOT NULL,
  total INTEGER NOT NULL,
  date TEXT NOT NULL
)
''');
  }

  Future<int> inscrireUtilisateur(String email, String mdp) async {
    final db = await instance.database;
    return await db.insert('utilisateurs', {
      'email': email,
      'mot_de_passe': mdp,
    }, conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<Map<String, dynamic>?> getUtilisateur(String email) async {
    final db = await instance.database;
    final resultat = await db.query(
      'utilisateurs',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (resultat.isNotEmpty) return resultat.first;
    return null;
  }

  Future<void> enregistrerScore(String email, int score, int total) async {
    final db = await instance.database;
    final date = DateTime.now().toIso8601String();

    await db.insert('scores', {
      'email': email,
      'score': score,
      'total': total,
      'date': date,
    });
  }

  Future<List<Map<String, dynamic>>> getScoresParEmail(String email) async {
    final db = await instance.database;
    return await db.query(
      'scores',
      where: 'email = ?',
      whereArgs: [email],
      orderBy: 'date DESC',
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
