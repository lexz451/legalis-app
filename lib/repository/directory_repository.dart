import 'package:flutter/foundation.dart';
import 'package:legalis/model/directory.dart';
import 'package:legalis/services/api_service.dart';

class DirectoryRepository {
  final ApiService apiService = ApiService();

  DirectoryRepository();

  Future<List<Directory>> fetchAll() async {
    var _res = await apiService.get<List<dynamic>>("directorios");
    return List<Directory>.from((_res ?? []).map((e) => Directory.fromMap(e)));
  }
}
