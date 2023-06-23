
import 'dart:convert';

import '../models/storage_model.dart';
import '../provider/db_provider.dart';

class StorageService {
  static StorageService? _instance;

  final userDataStorage = StorageModel(key: 'user_data', value: '');
  final tokenStorage = StorageModel(key: 'token', value: '');

  final Map<String, dynamic> userDataDecoded = {};
  final Map<String, String> tokenStorageDecoded = {};
  
  StorageService._();

  static StorageService getInstace() {
    _instance ??= StorageService._();
    return _instance!;
  }

  Future<void> cargarStorages() async {
    await getUserDataStorage();
    await getTokenStorage();
  }

  Future<void> deleteStorages() async {
    await deleteTokenStorage();
    await deleteUserDataStorage();
  }

  Future<void> getUserDataStorage() async {
    final db = DBProvider.db;

    final userDataStorageDB = await db.getStorage(userDataStorage.key);

    if(userDataStorageDB == null) return;

    userDataStorage.value = userDataStorageDB.value;
    final Map<String, dynamic> decodedData = json.decode(userDataStorageDB.value);
    userDataDecoded.addEntries(decodedData.entries);
  }

  Future<void> setUserDataStore(String value) async {
    final db = DBProvider.db;

    final userDataStorageDB = await db.getStorage(userDataStorage.key);

    if(userDataStorageDB != null) {
      userDataStorage.value = userDataStorageDB.value;
      await getUserDataStorage();
      return;
    }

    await db.setStorage(userDataStorage.key, value);

    userDataStorage.value = value;
    await getUserDataStorage();
  }

  Future<void> getTokenStorage() async {
    final db = DBProvider.db;
    final tokenStorageDB = await db.getStorage(tokenStorage.key);

    if(tokenStorageDB == null) return; 
    
    tokenStorage.value = tokenStorageDB.value;
    final Map<String, dynamic> decodedData = json.decode(tokenStorageDB.value);
    decodedData.forEach((key, value) {
      tokenStorageDecoded[key] = value;
    });
  }

  Future<void> setTokenStorage(String value) async {
    final db = DBProvider.db;

    final tokenStorageDB = await db.getStorage(tokenStorage.key);

    if(tokenStorageDB != null) return; 

    await db.setStorage(tokenStorage.key, value);

    tokenStorage.value = value;
    await getTokenStorage();
  }

  Future<void> deleteTokenStorage() async {
    final db = DBProvider.db;

    await db.deleteStorage(tokenStorage.key);

    tokenStorage.value = '';
  }

  Future<void> deleteUserDataStorage() async {
    final db = DBProvider.db;

    await db.deleteStorage(userDataStorage.key);

    userDataStorage.value = '';
    userDataDecoded.clear();
  }

  bool hasRole(String nombreRol) {
    if(userDataDecoded.isEmpty) return false;
    bool hasRole = false;

    for(Map<String, dynamic> roleMap in userDataDecoded['roles']) {
        if(roleMap.containsValue(nombreRol)) {
          hasRole = true;
          break;
        }
    }

    return hasRole;
  }

  String getUserFullName() {
    return '${userDataDecoded["nombre"]} ${userDataDecoded['apellido_paterno']} ${userDataDecoded['apellido_materno']}';
  }
}