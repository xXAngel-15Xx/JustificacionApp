import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:justificacion_app/src/models/credenciales_model.dart';
import 'package:justificacion_app/src/models/response_helper.dart';
import 'package:justificacion_app/src/provider/db_provider.dart';
import 'package:justificacion_app/src/services/storage_service.dart';
import 'package:justificacion_app/src/utils/sistema.dart';


class CuentasService extends ChangeNotifier {

  bool isLoading = false;

  Future<ResponseHelper> login(CredencialesModel credencialesUsuario) async {
    final url = Uri.parse("${Sistema.urlBase}/api/cuentas/login");
    final storageService = StorageService.getInstace();
    ResponseHelper response;

    isLoading = true;
    notifyListeners();

    try {
      final resp = await http.post(url, body: json.encode(credencialesUsuario.toJson()), headers: {
        'Content-Type': 'application/json'
      });

      final Map<String, dynamic> decodedData = json.decode(resp.body);

      if(resp.statusCode == 200) {
        await storageService.deleteTokenStorage();
        await storageService.setTokenStorage(json.encode({
          'token': decodedData['token'],
           'expires_at': decodedData['expires_at']
        })); 
        await storageService.deleteUserDataStorage();
        await storageService.setUserDataStore(json.encode(decodedData['helper_data']));
        await storageService.cargarStorages();
      }
      response = ResponseHelper.fromJson(decodedData);
    } catch (e) {
      response = ResponseHelper(success: false, message: 'Ocurrio un error inesperado, vuelva más tarde.');
    }
    isLoading = false;
    notifyListeners();
    return response;
  }

  Future<ResponseHelper> registrarAlumno(Map<String, String> alumno, int grupoId) async {
    final url = Uri.parse("${Sistema.urlBase}/api/cuentas/register/alumno");
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
    final url = Uri.parse("${Sistema.urlBase}/api/cuentas/register/profesor");
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
    final storageService = StorageService.getInstace();

    await storageService.deleteStorages();
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