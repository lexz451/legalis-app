import 'package:get_it/get_it.dart';
import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/person.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/about_repository.dart';
import 'package:legalis/utils/base_model.dart';

class AboutViewModel extends BaseModel {
  final aboutRepository = getIt<AboutRepository>();

  Resource<List<Person>> _team = Resource.loading();
  Resource<List<Person>> get team => _team;
  setTeam(Resource<List<Person>> team) {
    _team = team;
    notifyListeners();
  }

  loadTeam() async {
    setTeam(Resource.loading(data: _team.data));
    try {
      final _team = await aboutRepository.fetchTeam();
      setTeam(Resource.complete(_team));
    } catch (e) {
      LOGGER.e(e);
      setTeam(Resource.error(e.toString(), data: _team.data));
    }
  }
}
