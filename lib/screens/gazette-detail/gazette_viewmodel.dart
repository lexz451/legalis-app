import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/gazette_repository.dart';
import 'package:legalis/utils/base_model.dart';

class GazetteViewModel extends BaseModel {
  final gazetteRepository = getIt<GazetteRepository>();
  Resource<Gazette> _gazette = Resource.loading();

  @override
  bool get isLoading => _gazette.state == ResourceState.loading;

  Gazette? get gazette => _gazette.data;

  setGazette(gazette) {
    _gazette = gazette;
    notifyListeners();
  }

  fetchGazette(id) async {
    setGazette(Resource.loading(data: _gazette.data));
    try {
      final _res = await gazetteRepository.fetchById(id);
      setGazette(Resource.complete(_res));
    } catch (e) {
      LOGGER.e(e);
      setGazette(Resource.error(e.toString(), data: _gazette.data));
    }
  }
}
