import 'package:get_it/get_it.dart';
import 'package:legalis/model/person.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/about_repository.dart';
import 'package:legalis/utils/base_model.dart';

class AboutViewModel extends BaseModel {
  final aboutRepository = GetIt.I<AboutRepository>();

  Resource<List<Person>> _team = Resource.loading();

  Resource<List<Person>> get team => _team;

  set team(Resource<List<Person>> team) {
    _team = team;
    notifyListeners();
  }

  loadTeam() async {
    team = Resource.loading();
    try {
      final _team = await aboutRepository.fetchTeam();
      team = Resource.complete(_team);
    } catch (e) {
      team = Resource.error(e.toString());
    }
  }
}
