import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:justificacion_app/src/models/credenciales_model.dart';
import 'package:justificacion_app/src/models/response_helper.dart';
import 'package:justificacion_app/src/models/user_model.dart';
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

  Future<ResponseHelper> registrarAlumno(Map<String, String> alumno, int grupoId) async {
    final url = Uri.parse("$urlBase/api/cuentas/register/alumno");
    alumno.addAll({'grupo_id': grupoId.toString()});

    final resp = await http.post(url, body: alumno);
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if(decodedData.containsKey('errors')) {
      final response = ResponseHelper(success: false, message: '');
      final Map<String, dynamic> errors = decodedData['errors'];
      StringBuffer stringBuffer = StringBuffer();

      stringBuffer.write('Tienes los siguientes errores de validacion:\n');

      errors.forEach((key, value) {
        if(key == 'password') {
          stringBuffer.write('contraseña:\n');
        } else {
          stringBuffer.write(key);
        }
        for(var error in value) {
          stringBuffer.write('\t $error \n');
        }
      });

      response.message = stringBuffer.toString();
      
      return response;
    }

    return ResponseHelper.fromJson(decodedData);
  }

  Future<ResponseHelper> registerProfesor(Map<String, String> profesor, List<int> gruposIds) async {
    final url = Uri.parse("$urlBase/api/cuentas/register/profesor");
    final Map<String, dynamic> profesorMap = {
      'grupos': gruposIds.toList(),
    };

    profesor.forEach((key, value) {
      profesorMap[key] = value;
    });

    final resp = await http.post(url, body: json.encode(profesorMap), headers: {
      'Content-Type': 'application/json'
    });
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if(decodedData.containsKey('errors')) {
      final response = ResponseHelper(success: false, message: '');
      final Map<String, dynamic> errors = decodedData['errors'];
      StringBuffer stringBuffer = StringBuffer();

      stringBuffer.write('Tienes los siguientes errores de validacion:\n');

      errors.forEach((key, value) {
        if(key == 'password') {
          stringBuffer.write('contraseña:\n');
        } else {
          stringBuffer.write(key);
        }
        for(var error in value) {
          stringBuffer.write('\t $error \n');
        }
      });

      response.message = stringBuffer.toString();
      
      return response;
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

  Future<bool> isValidToken() async {
    bool isValid = false;
    
    final db = DBProvider.db;
    final tokenExpirationDateStorage = await db.getStorage('token_expiration_date');

    if(tokenExpirationDateStorage == null) return isValid;

    final DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
    final tokenExpirationDate = format.parse(tokenExpirationDateStorage.value);
    final today = DateTime.now();
    final difference = today.difference(tokenExpirationDate);
    
    if(difference.inMinutes < 60) {
      isValid = true;
    }

    return isValid;
  }

}