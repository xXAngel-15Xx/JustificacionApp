import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:justificacion_app/src/models/credenciales_model.dart';
import 'package:justificacion_app/src/models/response_helper.dart';
import 'package:justificacion_app/src/provider/db_provider.dart';


class CuentasService extends ChangeNotifier {
  final String urlBase = 'http://192.168.1.10:8080/justificaciones-backend/public';

  Future<ResponseHelper> login(CredencialesModel credencialesUsuario) async {
    final url = Uri.parse("$urlBase/api/cuentas/login");
    final db = DBProvider.db;

    final resp = await http.post(url, body: credencialesUsuario.toJson());

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if(decodedData['success']) {
      if(decodedData.containsKey('token')) {
        await db.setStorage('token', decodedData['token']);
        await db.setStorage('token_expiration_date', decodedData['expires_at']);
        decodedData.remove('token');
      }
      if(decodedData.containsKey('helper_data')) {
        await db.setStorage('user_data', json.encode(decodedData['helper_data']));
      }
    }
    
    return ResponseHelper.fromJson(decodedData);
  }

  Future<void> logout() async {
    // await storege.delete(key: 'token');
    final db = DBProvider.db;
    await db.deleteStorage('token');
    await db.deleteStorage('token_expiration_date');
    await db.deleteStorage('user_data');
  }


}