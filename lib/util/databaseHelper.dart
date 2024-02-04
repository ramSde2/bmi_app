import 'dart:io';

import 'package:app_demo/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  late Database _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._internal();
    }
    return _instance!;
  }

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    } else {
      _database = await initializeDatabase();
      return _database;
    }
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'userinfo.db');
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE userinfotable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'height TEXT, '
        'weight TEXT, '
        
        'date TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await database;
    return await db.query('userinfotable');
  }

  Future<int> insert(User note) async {
    Database db = await database;
    return await db.insert('userinfotable', note.toMap());
  }

  Future<int> updatedata(User note) async {
    Database db = await database;
    return await db.update('userinfotable', note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.rawDelete('DELETE FROM userinfotable WHERE id = $id');
  }

  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from note_table');
    return Sqflite.firstIntValue(x) ?? 0;
  }

  Future<List<User>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    return List.generate(noteMapList.length,
        (index) => User.fromMapObject(noteMapList[index]));
  }
}
