import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:justificacion_app/src/models/grupo_model.dart';
import '../models/response_helper.dart';
import '../provider/db_provider.dart';

class GruposService extends ChangeNotifier {
  List<GruposModel> grupos = [];
  int? idGrupoSelected;

  final String urlBase = 'http://192.168.1.10:8080/justificaciones-backend/public';

  GruposService(){
    cargarGrupos();
  }
  
  Future<void> cargarGrupos() async {
    final url = Uri.parse("$urlBase/api/grupos/with-users");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    if(tokenStorage == null) {
      await cargarGruposSinAuth();
      return;
    }

    final resp = await http.get(url, headers: {
      'Authorization': 'Bearer ${tokenStorage.value}'
    });

    final List<dynamic> gruposList = json.decode(resp.body);

    for (var element in gruposList) {
      final tempJustificacion = GruposModel.fromJson(element);
      grupos.add(tempJustificacion);
    }

    notifyListeners();
  }

  Future<void> cargarGruposSinAuth() async {
    final url = Uri.parse("$urlBase/api/grupos");

    final resp = await http.get(url);

    final List<dynamic> gruposList = json.decode(resp.body);

    for (var element in gruposList) {
      final tempJustificacion = GruposModel.fromJson(element);
      grupos.add(tempJustificacion);
    }

    notifyListeners();
  }

  Future<GruposModel?> obtenerPorId(int id) async {
    final url = Uri.parse("$urlBase/api/grupos/$id");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    if(tokenStorage == null) return null;

    final resp = await http.get(url, headers: {
      'Authorization': 'Bearer ${tokenStorage.value}'
    });

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    return GruposModel.fromJson(decodedData);
  }

  Future<ResponseHelper> crear(GruposModel grupo) async {
    final url = Uri.parse("$urlBase/api/grupos");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    if(tokenStorage == null) return ResponseHelper(success: false, message: 'Ocurrio un error');

    final resp = await http.post(url, 
      body: grupo.toJson(),
      headers: {
        'Authorization': 'Bearer ${tokenStorage.value}'
      }
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    return ResponseHelper.fromJson(decodedData);
  }

  Future<ResponseHelper> actualizar(int id, GruposModel grupo) async {
    final url = Uri.parse("$urlBase/api/grupos/$id");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    if(tokenStorage == null) return ResponseHelper(success: false, message: 'Ocurrio un error');

    final resp = await http.put(url, 
      body: grupo.toJson(),
      headers: {
        'Authorization': 'Bearer ${tokenStorage.value}'
      }
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    return ResponseHelper.fromJson(decodedData);
  }
  
  Future<ResponseHelper> eliminar(int id) async {
    final url = Uri.parse("$urlBase/api/grupos/$id");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    if(tokenStorage == null) return ResponseHelper(success: false, message: 'Ocurrio un error');

    final resp = await http.delete(url, 
      headers: {
        'Authorization': 'Bearer ${tokenStorage.value}'
      }
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    return ResponseHelper.fromJson(decodedData);
  }


}