import 'package:get_it/get_it.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/model/topic.dart';
import 'package:legalis/services/api_service.dart';
import 'package:legalis/services/localstorage_service.dart';

class NormativeRepository {
  final apiService = GetIt.I<APIService>();

  Future<Paged<Normative>> fetchByDirectoryId(directoryId) async {
    var _res = await apiService
        .get("/normativas", params: {'directory': directoryId.toString()});
    return Paged.fromMap(_res, Normative.fromMap);
  }

  Future<List<Topic>> fetchNormativeTopics() async {
    var _res = await apiService.get('/normativas/tematicas');
    return List.from(_res ?? []).map((e) => Topic.fromMap(e)).toList();
  }

  Future<Normative> fetchById(String id) async {
    var _res = await apiService.get("/normativas/$id");
    return Normative.fromMap(_res);
  }
}
