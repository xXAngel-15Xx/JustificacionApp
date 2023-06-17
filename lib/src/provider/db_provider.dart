import 'dart:io';

import 'package:justificacion_app/src/models/storage_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'justificaciones.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('PRAGMA foreign_keys = ON;');

      await db.execute('''
        CREATE TABLE storage (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          key TEXT UNIQUE,
          value TEXT
        )
      ''');
    });
  }

  Future<bool> setStorage(String key, String value) async {
    final db = await database;

    final storageExistente = await getStorage(key);

    if(storageExistente != null) {
      return true;
    }

    final id = await db!.insert('storage', {'key': key, 'value': value});

    return id > 0;
  }

  Future<StorageModel?> getStorage(String key) async {
    final db = await database;
    final List<Map<String, dynamic>> registros = await db!.query(
      'storage', 
      where: 'key = ?',
      whereArgs: [key],
      limit: 1
    );

    return registros.isEmpty ? null : StorageModel.fromJson(registros.first);
  }

  Future<bool> deleteStorage(String key) async {
    final db = await database;
    final registrosAfectados = await db!.delete('storage', where: 'key = ?', whereArgs: [key]);

    return registrosAfectados > 0;
  }

}
