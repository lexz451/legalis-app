import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

class StorageService {
  final storage = LocalStorage("legalis.json");

  Future<StorageService> init() async {
    await storage.ready;
    return this;
  }

  Future<bool> saveItem(String key, dynamic data) async {
    try {
      await storage.setItem(key, data);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  getItem(String key) {
    return storage.getItem(key);
  }

  dispose() => storage.dispose();
}
