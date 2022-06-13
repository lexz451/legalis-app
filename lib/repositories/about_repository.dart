import 'package:get_it/get_it.dart';
import 'package:legalis/model/person.dart';
import 'package:legalis/services/api_service.dart';

class AboutRepository {
  final apiService = GetIt.I<APIService>();

  Future<List<Person>> fetchTeam() async {
    final res = await apiService.get('/quienessomos');
    return List.from(res['results'] ?? [])
        .map((e) => Person.fromMap(e))
        .toList();
  }
}
