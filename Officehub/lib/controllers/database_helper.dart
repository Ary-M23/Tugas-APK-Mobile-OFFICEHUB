import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'user.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            uid TEXT
          )
          ''');
      },
    );
  }

  Future<void> deleteDatabase() async {
    final db = await database;
    await db.delete('user');
    print('Deleted all users');
  }

  Future<void> insertUser(String email, String uid) async {
    final db = await database;
    await db.insert(
      'user',
      {'email': email, 'uid': uid},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted User: email: $email, uid: $uid');
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('user');
  }

  Future<bool> isDatabaseEmpty() async {
    final db = await database;
    final count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM user'));
    return count == 0;
  }
}
