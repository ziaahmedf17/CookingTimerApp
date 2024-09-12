import 'package:cooking_app/constants/db_constants.dart';
import 'package:cooking_app/models/dish_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'example.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DbConstants.tableDishes}(
        ${DbConstants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.colName} TEXT,
        ${DbConstants.colOvenTem} INTEGER,
        ${DbConstants.colDuration} INTEGER,
        ${DbConstants.colReminder}  TEXT,
        ${DbConstants.colServeTime}  TEXT,
        ${DbConstants.colNotes} TEXT
      )
    ''');
  }

  Future<int> insertDish(Dish dish) async {
    Database db = await database;
    return await db.insert(DbConstants.tableDishes, dish.toMapToInsert());
  }

  Future<List<Map<String, dynamic>>> getDishes() async {
    Database db = await database;
    final data = await db.query(DbConstants.tableDishes);
    for (var element in data) {
      print(
          ' ${element[DbConstants.colOvenTem]} type   ${element[DbConstants.colOvenTem].runtimeType}');
    }
    return data;
  }

  Future<int> updateDish(Dish dish) async {
    Database db = await database;
    // int id = dish['id'];
    print(dish);
    print(dish.toMapToUpdate());
    return await db.update(DbConstants.tableDishes, dish.toMapToUpdate(),
        where: 'id = ?', whereArgs: [dish.id]);
  }

  Future<int> deleteDish(int id) async {
    print('id in database $id');
    Database db = await database;
    return await db
        .delete(DbConstants.tableDishes, where: 'id = ?', whereArgs: [id]);
  }
   Future<List<String>> getDishNames() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'Dishes',
      columns: [DbConstants.colName], // Select only the 'name' column
    );
    return result.map((e) => e['name'] as String).toList();
  }
}
