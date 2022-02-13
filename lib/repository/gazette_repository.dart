import 'package:flutter/foundation.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/services/api_service.dart';
import 'package:legalis/services/connectivity_service.dart';
import 'package:legalis/services/local_storage_service.dart';

class GazetteRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;
  final ConnectivityService connectivityService;

  const GazetteRepository(
      {required this.apiService,
      required this.localStorageService,
      required this.connectivityService});

  Future<bool> isConnected() async {
    return await this.connectivityService.isConnected();
  }

  Future<List<Gazette>> getAll(Map<String, String> params) async {
    var res = await apiService.get("gacetas", params: params);
    return compute(_parseGazettes, res);
  }
}

List<Gazette> _parseGazettes(dynamic data) {
  if (data == null) return [];
  var gazettes = data as List<dynamic>;
  return gazettes.map((e) => Gazette.fromMap(e)).toList();
}
