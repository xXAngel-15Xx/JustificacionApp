import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:justificacion_app/src/provider/db_provider.dart';

class UserDataProvider extends ChangeNotifier {
  Map<String, dynamic> userData = {};
  String token = '';
  String tokenExpirationDate = '';

  Future<void> cargarData() async {
    final db = DBProvider.db;

    final userDataStorage = await db.getStorage('user_data');
    final tokenStorage = await db.getStorage('token');
    final tokenExpirationDateStorage = await db.getStorage('token_expiration_date');
    if(userDataStorage != null) {
      userData = json.decode(userDataStorage.value);
    }
    if(tokenStorage != null) {
      token = tokenStorage.value;
    }
    if(tokenExpirationDateStorage != null) {
      tokenExpirationDate = tokenExpirationDateStorage.value;
    }
  }

  Future<void> borrarDatosUsuario() async {
    await DBProvider.db.deleteStorage('user_data');
    userData = {};
    notifyListeners();
  }

  bool hasRole(String roleName) {
    bool hasRole = false;
    if(userData.isEmpty) return hasRole;
    final roles = List<Map<String, dynamic>>.from(userData['roles'].map((x) => x));
    
    for(var roleDB in roles) {
      if(roleDB.containsKey('role_name') && roleDB['role_name'] == roleName) {
        hasRole = true;
        break;
      }
    }

    return hasRole;
  }

  String get fullName => '${userData['nombre']} ${userData['apellido_paterno']} ${userData['apellido_materno']}';
}