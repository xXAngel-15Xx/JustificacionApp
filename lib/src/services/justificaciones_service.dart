import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/response_helper.dart';
import '../provider/db_provider.dart';
import 'package:justificacion_app/src/models/justificacion_model.dart';

class JustificacionesService extends ChangeNotifier {
  final String urlBase = 'http://192.168.1.10:8080/justificaciones-backend/public';

  List<JustificacionModel> justificaciones = [];

  bool isLoading = true;

  JustificacionesService();


  cargarJustificaciones(BuildContext context) async {
    final url = Uri.parse("$urlBase/api/justificaciones");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    justificaciones = [];

    isLoading = true;

    final resp = await http.get(url, headers: {
      'Authorization': 'Bearer ${tokenStorage?.value}'
    });

    final List<dynamic> justificacionesList = json.decode(resp.body);

    for (var element in justificacionesList) {
      final tempJustificacion = JustificacionModel.fromJson(element);
      justificaciones.add(tempJustificacion);
    }

    isLoading = false;

    notifyListeners();
  }

  void vaciarJustificaciones() {
    justificaciones.clear();
    notifyListeners();
  }

  Future<JustificacionModel?> obtenerPorId(int id) async {
    final url = Uri.parse("$urlBase/api/justificaciones/$id");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    if(tokenStorage == null) return null;

    final resp = await http.get(url, headers: {
      'Authorization': 'Bearer ${tokenStorage.value}'
    });

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    return JustificacionModel.fromJson(decodedData);
  }

  Future<ResponseHelper> crear(JustificacionModel justificacion) async {
    final url = Uri.parse("$urlBase/api/justificaciones");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    if(tokenStorage == null) return ResponseHelper(success: false, message: 'Ocurrio un error');

    final resp = await http.post(url, 
      body: json.encode(justificacion.toJson()),
      headers: {
        'Authorization': 'Bearer ${tokenStorage.value}',
        'Content-Type': 'application/json'
      }
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    return ResponseHelper.fromJson(decodedData);
  }

  Future<ResponseHelper> actualizar(int id, JustificacionModel grupo) async {
    final url = Uri.parse("$urlBase/api/justificaciones/$id");
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
    final url = Uri.parse("$urlBase/api/justificaciones/$id");
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