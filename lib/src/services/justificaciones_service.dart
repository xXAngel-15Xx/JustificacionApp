import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../provider/db_provider.dart';
import 'package:justificacion_app/src/models/justificacion_model.dart';

class JustificacionesService extends ChangeNotifier {
  final String urlBase = 'http://192.168.1.10:8080/justificaciones-backend/public';

  List<JustificacionModel> justificaciones = [];

  JustificacionesService(){
    cargarJustificaciones();
  }


  Future<void> cargarJustificaciones() async {
    final url = Uri.parse("$urlBase/api/justificaciones");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    final resp = await http.get(url, headers: {
      'Authorization': 'Bearer ${tokenStorage?.value}'
    });

    final List<dynamic> justificacionesList = json.decode(resp.body);

    for (var element in justificacionesList) {
      final tempJustificacion = JustificacionModel.fromJson(element);
      justificaciones.add(tempJustificacion);
    }

    notifyListeners();
  }
}