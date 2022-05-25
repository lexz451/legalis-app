import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/gazette_type.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/services/api_service.dart';

class GazetteRepository {
  final apiService = GetIt.I<APIService>();

  Future<Paged<Gazette>> fetchAll({params}) async {
    final _res = await apiService.get("/gacetas");
    return Paged.fromMap(_res, Gazette.fromMap);
  }

  Future<Gazette?> fetchLatest() async {
    final _res =
        await apiService.get("/gacetas", params: {'page': 1, 'page_size': 1});
    final _gazettes = List.from(_res['results'].map((e) => Gazette.fromMap(e)));
    return _gazettes.isNotEmpty ? _gazettes[0] : null;
  }

  Future<Gazette> fetchById(id) async {
    final _res = await apiService.get('/gacetas/$id/');
    return Gazette.fromMap(_res);
  }

  Future<List<GazetteType>> fetchTypes() async {
    final _res = await apiService.get('/gacetas/tipos');
    return List.from(_res ?? []).map((e) => GazetteType.fromMap(e)).toList();
  }
}
