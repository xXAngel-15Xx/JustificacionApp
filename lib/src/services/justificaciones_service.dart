import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:justificacion_app/src/services/storage_service.dart';

import '../models/response_helper.dart';
import '../provider/db_provider.dart';
import 'package:justificacion_app/src/models/justificacion_model.dart';

import '../utils/sistema.dart';

class JustificacionesService extends ChangeNotifier {
  final String urlBase = 'http://192.168.1.10:8080/justificaciones-backend/public';

  List<JustificacionModel> justificaciones = [];

  bool isLoading = true;
  bool isLoadingCreateOrUpdated = false;

  final StreamController<List<JustificacionModel>> _searchGruposStreamController = StreamController.broadcast();
  Stream<List<JustificacionModel>> get searchGruposStream => _searchGruposStreamController.stream;

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

  Future<void> searchGrupos({String searchTerm = ''}) async {
    final url = Uri.parse('${Sistema.urlBase}/api/grupos/with-users?param=$searchTerm');
    final storageService = StorageService.getInstace();

    isLoading = true;
    notifyListeners();

    try {
      await storageService.cargarStorages();

      if(storageService.tokenStorageDecoded.isEmpty) return;

      final resp = await http.get(url, headers: {
        'Authorization': 'Bearer ${storageService.tokenStorageDecoded['token']}'
      });

      if(resp.statusCode == 200) {
        final List<dynamic> gruposList = json.decode(resp.body);
        final List<JustificacionModel> gruposSearch = [];

        for (var element in gruposList) {
          final tempJustificacion = JustificacionModel.fromJson(element);
          gruposSearch.add(tempJustificacion);
        }

        _searchGruposStreamController.sink.add(gruposSearch);
        isLoading = false;
        notifyListeners();
      }

    } catch(e) {
      isLoading = false;
      notifyListeners();
      _searchGruposStreamController.sink.add(List.empty());
    }
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
    final url = Uri.parse("${Sistema.urlBase}/api/justificaciones");
    final storageService = StorageService.getInstace();

    isLoadingCreateOrUpdated = true;
    notifyListeners();

    try {
      await storageService.cargarStorages();

      if(storageService.tokenStorageDecoded.isEmpty) return ResponseHelper(success: false, message: 'Tiempo de sesión expirado, cierra sesión y ingrese nuevamente.');

      final resp = await http.post(url, 
        body: json.encode(justificacion.toJson()),
        headers: {
          'Authorization': 'Bearer ${storageService.tokenStorageDecoded['token']}',
          'Content-Type': 'application/json'
        }
      );

      final Map<String, dynamic> decodedData = json.decode(resp.body);

      isLoadingCreateOrUpdated = false;
      notifyListeners();

      return ResponseHelper.fromJson(decodedData);
      
    } catch (e) {
      isLoadingCreateOrUpdated = false;
      notifyListeners();
      return ResponseHelper(success: false, message: 'Ha ocurrido un error inesperado.');
    }
  }

  Future<ResponseHelper> actualizar(int id, JustificacionModel justificacion) async {
    final url = Uri.parse("${Sistema.urlBase}/api/justificaciones/$id");
    final storageService = StorageService.getInstace();

    isLoadingCreateOrUpdated = true;
    notifyListeners();

    try {
      await storageService.cargarStorages();

      if(storageService.tokenStorageDecoded.isEmpty) return ResponseHelper(success: false, message: 'Tiempo de sesión expirado, cierra sesión y ingrese nuevamente.');

      final resp = await http.put(url, 
        body: json.encode(justificacion.toJson()),
        headers: {
          'Authorization': 'Bearer ${storageService.tokenStorageDecoded['token']}',
          'Content-Type' : 'application/json'
        }
      );

      final Map<String, dynamic> decodedData = json.decode(resp.body);

      isLoadingCreateOrUpdated = false;
      notifyListeners();

      return ResponseHelper.fromJson(decodedData);
    } catch (e) {
      isLoadingCreateOrUpdated = false;
      notifyListeners();
      return ResponseHelper(success: false, message: 'Ha ocurrido un error inesperado');
    }
  }
  
  Future<ResponseHelper> eliminar(int id) async {
    final url = Uri.parse("${Sistema.urlBase}/api/justificaciones/$id");
    final storageService = StorageService.getInstace();

    try {
      await storageService.cargarStorages();

      if(storageService.tokenStorageDecoded.isEmpty) return ResponseHelper(success: false, message: 'Tiempo de sesión expirado, cierra sesión y ingrese nuevamente.');

      final resp = await http.delete(url, 
        headers: {
          'Authorization': 'Bearer ${storageService.tokenStorageDecoded['token']}'
        }
      );

      final Map<String, dynamic> decodedData = json.decode(resp.body);

      return ResponseHelper.fromJson(decodedData);
      
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return ResponseHelper(success: false, message: 'Ha ocurrido un error inesperado.');
    }
  }
}