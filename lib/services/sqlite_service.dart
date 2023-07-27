import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteService {
  // static final SQLiteService _instance = SQLiteService._internal();

  // factory SQLiteService() => _instance;

  // SQLiteService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'entertainment.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> resetDatabase() async {
    final db = await database;
    await db.close();

    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'entertainment.db');
    await deleteDatabase(path);

    _database = null; // Reset the database instance to null

    await database; // Recreate the database and tables
  }

  Future<void> delDatabase() async {
    final db = await database;
    await db.close();

    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'entertainment.db');
    await deleteDatabase(path);

    _database = null; // Reset the database instance to null
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Videos (
        id INTEGER PRIMARY KEY,
        title TEXT,
        releaseDate TEXT,
        isVR INTEGER,
        type TEXT,
        resolution TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Actors (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Studios (
        id INTEGER PRIMARY KEY,
        name TEXT,
        location TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS VideoActor (
        id INTEGER PRIMARY KEY,
        videoId INTEGER,
        actorId INTEGER,
        FOREIGN KEY (videoId) REFERENCES Videos (id) ON DELETE CASCADE,
        FOREIGN KEY (actorId) REFERENCES Actors (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS VideoStudio (
        id INTEGER PRIMARY KEY,
        videoId INTEGER,
        studioId INTEGER,
        FOREIGN KEY (videoId) REFERENCES Videos (id) ON DELETE CASCADE,
        FOREIGN KEY (studioId) REFERENCES Studios (id) ON DELETE CASCADE
      )
    ''');
  }
}
