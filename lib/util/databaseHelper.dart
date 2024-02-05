import 'dart:io';
import 'package:app_demo/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  
  final Database database;

  DatabaseHelper(this.database);
 

  

  

 

  

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
        where: 'date = ?', // Use 'date' instead of 'id'
      whereArgs: [note.date]);
  }

  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.rawDelete('DELETE FROM userinfotable WHERE id = $id');
  }

  

  Future<List<User>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    return List.generate(
        noteMapList.length, (index) => User.fromMapObject(noteMapList[index]));
  }
  



}
