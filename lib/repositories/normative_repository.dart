import 'package:get_it/get_it.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/normative_state.dart';
import 'package:legalis/model/normative_thematic.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/model/topic.dart';
import 'package:legalis/services/api_service.dart';

class NormativeRepository {
  final apiService = GetIt.I<APIService>();

  Future<Paged<Normative>> fetchByDirectoryId(directoryId,
      {int page = 1, int pageSize = 5}) async {
    var res = await apiService.get("/normativas", params: {
      'directory': directoryId.toString(),
      'page': page,
      'page_size': pageSize
    });
    return Paged.fromMap(res, Normative.fromMap);
  }

  Future<List<Topic>> fetchNormativeTopics() async {
    var res = await apiService.get('/normativas/tematicas');
    return List.from(res ?? []).map((e) => Topic.fromMap(e)).toList();
  }

  Future<Normative> fetchById(String id) async {
    var res = await apiService.get("/normativas/$id");
    return Normative.fromMap(res);
  }

  Future<Paged<Normative>> searchNormatives(params, {pageSize = 5}) async {
    var res = await apiService.get("/search",
        params: {...params, 'page_size': pageSize}, refresh: true);
    return Paged<Normative>.fromMap(res, Normative.fromMap);
  }

  Future<List<NormativeState>> getNormativeStates() async {
    var res = await apiService.get('/normativas/estados');
    return List<NormativeState>.from(res.map((e) => NormativeState.fromMap(e)));
  }

  Future<List<NormativeThematic>> getNormativeThematics() async {
    var res = await apiService.get('/normativas/tematicas');
    return List<NormativeThematic>.from(
        res.map((e) => NormativeThematic.fromMap(e)));
  }

  Future<List<String>> getNormativeOrganisms() async {
    var res = await apiService.get("/normativas/organismos");
    return List<String>.from(res.map((e) => e.toString()));
  }
}
