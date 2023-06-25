import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:justificacion_app/src/models/grupo_model.dart';
import 'package:justificacion_app/src/services/storage_service.dart';
import '../models/response_helper.dart';
import '../utils/sistema.dart';

class GruposService extends ChangeNotifier {
  List<GruposModel> grupos = [];
  int? idGrupoSelected;
  bool isLoading = false;
  bool isLoadingCreateOrUpdated = false;

  final StreamController<List<GruposModel>> _searchGruposStreamController = StreamController.broadcast();
  Stream<List<GruposModel>> get searchGruposStream => _searchGruposStreamController.stream;

  GruposService(){
    cargarGrupos();
  }
  
  Future<void> cargarGrupos() async {
    final url = Uri.parse("${Sistema.urlBase}/api/grupos/with-users");
    final storageService = StorageService.getInstace();

    isLoading = true;
    notifyListeners();

    try {
      await storageService.cargarStorages();

      if(storageService.tokenStorageDecoded.isEmpty) {
        await cargarGruposSinAuth();
        return;
      }

      final resp = await http.get(url, headers: {
        'Authorization': 'Bearer ${storageService.tokenStorageDecoded['token']}'
      });

      if(resp.statusCode == 200) {
        final List<dynamic> gruposList = json.decode(resp.body);

        grupos.clear();

        for (var element in gruposList) {
          final tempJustificacion = GruposModel.fromJson(element);
          grupos.add(tempJustificacion);
        }
      }
    } catch (e) {
      grupos.clear();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> cargarGruposSinAuth() async {
    final url = Uri.parse("${Sistema.urlBase}/api/grupos");

    isLoading = true;
    notifyListeners();

    try {
      final resp = await http.get(url);

      final List<dynamic> gruposList = json.decode(resp.body);

      grupos.clear();

      for (var element in gruposList) {
        final tempJustificacion = GruposModel.fromJson(element);
        grupos.add(tempJustificacion);
      }
    } catch (e) {
      grupos.clear();
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
        final List<GruposModel> gruposSearch = [];

        for (var element in gruposList) {
          final tempJustificacion = GruposModel.fromJson(element);
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

  Future<GruposModel?> obtenerPorId(int id) async {
    final url = Uri.parse("${Sistema.urlBase}}/api/grupos/$id");
    final storageService = StorageService.getInstace();

    if(storageService.tokenStorageDecoded.isEmpty) return null;

    final resp = await http.get(url, headers: {
      'Authorization': 'Bearer ${storageService.tokenStorageDecoded['token']}'
    });

    if(resp.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(resp.body);

      return GruposModel.fromJson(decodedData);

    }
    return null;
  }

  Future<ResponseHelper> crear(GruposModel grupo) async {
    final url = Uri.parse("${Sistema.urlBase}/api/grupos");
    final storageService = StorageService.getInstace();

    isLoadingCreateOrUpdated = true;
    notifyListeners();

    try {
      await storageService.cargarStorages();

      if(storageService.tokenStorageDecoded.isEmpty) return ResponseHelper(success: false, message: 'Tiempo de sesión expirado, cierra sesión y ingrese nuevamente.');

      final resp = await http.post(url, 
        body: json.encode(grupo.toJson()),
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

  Future<ResponseHelper> actualizar(int id, GruposModel grupo) async {
    final url = Uri.parse("${Sistema.urlBase}/api/grupos/$id");
    final storageService = StorageService.getInstace();

    isLoadingCreateOrUpdated = true;
    notifyListeners();

    try {
      await storageService.cargarStorages();

      if(storageService.tokenStorageDecoded.isEmpty) return ResponseHelper(success: false, message: 'Tiempo de sesión expirado, cierra sesión y ingrese nuevamente.');

      final resp = await http.put(url, 
        body: json.encode(grupo.toJson()),
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
    final url = Uri.parse("${Sistema.urlBase}/api/grupos/$id");
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