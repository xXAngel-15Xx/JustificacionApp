import 'dart:io';

import 'package:justificacion_app/src/models/grupo_model.dart';
import 'package:justificacion_app/src/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  final String _gruposTable = 'Grupos';
  final String _usuariosTable = 'Usuarios';
  final String _grupoUsuarioTable = 'GrupoUsuario';
  final String _justificacionesTable = 'Justificaciones';

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'justificaciones.db');

    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('PRAGMA foreign_keys = ON;');

      await db.execute('''
          CREATE TABLE $_gruposTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT
          );
          
          CREATE TABLE $_usuariosTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombres TEXT,
            apellido_materno TEXT,
            apellido_paterno TEXT,
            email TEXT,
            password TEXT,
            role TEXT,
            numero_control INTERGER NULL,
            carrera TEXT NULL,
            semestre TEXT NULL
          );
          
          CREATE TABLE $_grupoUsuarioTable(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              FOREING KEY (usuario_id) REFERENCES $_usuariosTable(id),
              FOREING KEY (grupo_id) REFERENCES $_gruposTable(id),
          );

          CREATE TABLE $_justificacionesTable(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nombre TEXT,
              fecha_inicio TEXT,
              fecha_fin TEXT,
              motivo TEXT,
              FOREING KEY (profesor_id) REFERENCES $_usuariosTable(id),
              FOREING KEY (alumno_id) REFERENCES $_usuariosTable(id),
          );
      ''');
    });
  }

  Future<int> nuevoGrupo() async {
    final grupo = GrupoModel(id: 1, nombre: 'GRUPO1');

    final db = await database;

    final grupoMap = grupo.toJson();
    grupoMap.remove('id');

    final res = await db!.insert(_gruposTable, grupoMap);

    return res;
  }

  Future<int> nuevoUser(UserModel user) async {
    final db = await database;
    
    final userMap = user.toJson();
    userMap.remove('id');

    final res = await db!.insert(_usuariosTable, userMap);

    return res;
  }


}
