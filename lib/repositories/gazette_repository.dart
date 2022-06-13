import 'package:get_it/get_it.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/gazette_type.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/services/api_service.dart';

class GazetteRepository {
  final apiService = GetIt.I<APIService>();

  Future<Paged<Gazette>> fetchAll({params}) async {
    final res = await apiService.get("/gacetas", params: params);
    return Paged.fromMap(res, Gazette.fromMap);
  }

  Future<Gazette?> fetchLatest() async {
    final res =
        await apiService.get("/gacetas", params: {'page': 1, 'page_size': 1});
    final gazettes = List.from(res['results'].map((e) => Gazette.fromMap(e)));
    return gazettes.isNotEmpty ? gazettes[0] : null;
  }

  Future<Gazette> fetchById(id) async {
    final res = await apiService.get('/gacetas/$id/');
    return Gazette.fromMap(res);
  }

  Future<List<GazetteType>> fetchTypes() async {
    final res = await apiService.get('/gacetas/tipos');
    return List.from(res ?? []).map((e) => GazetteType.fromMap(e)).toList();
  }
}
