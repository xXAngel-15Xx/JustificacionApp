import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:justificacion_app/src/models/grupo_model.dart';
import '../provider/db_provider.dart';

class GruposService extends ChangeNotifier {
  List<GruposModel> grupos = [];
  int? idGrupoSelected;

  final String urlBase = 'http://192.168.1.10:8080/justificaciones-backend/public';

  GruposService(){
    cargarGrupos();
  }
  
  Future<void> cargarGrupos() async {
    final url = Uri.parse("$urlBase/api/grupos");
    final db = DBProvider.db;
    final tokenStorage = await db.getStorage('token');

    final resp = await http.get(url, headers: {
      'Authorization': 'Bearer ${tokenStorage?.value}'
    });

    final List<dynamic> gruposList = json.decode(resp.body);

    for (var element in gruposList) {
      final tempJustificacion = GruposModel.fromJson(element);
      grupos.add(tempJustificacion);
    }

    notifyListeners();
  }

  Future<void> changeGrupoSelected(int? newIdGrupoSelected) async {
    idGrupoSelected = newIdGrupoSelected;
    notifyListeners();
  }


}