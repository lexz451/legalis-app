import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class LocalStorageService {
  final LocalStorage _storage = LocalStorage("legalis_app");

  void saveItem(String key, dynamic content) {
    _storage.setItem(key, content);
  }

  dynamic getItem(String key) {
    return _storage.getItem(key);
  }

  void deleteItem(String key) {
    _storage.deleteItem(key);
  }

  void clear() {
    _storage.clear();
  }
}
