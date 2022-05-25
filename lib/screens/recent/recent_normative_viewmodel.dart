import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/gazette_repository.dart';
import 'package:legalis/utils/base_model.dart';

class RecentNormativeViewModel extends BaseModel {
  final gazetteRepository = getIt<GazetteRepository>();

  Resource<Gazette?> _gazette = Resource.loading();
  Resource<Gazette?> get gazette => _gazette;

  List<Normative> get normatives => _gazette.data?.normatives ?? [];

  setGazette(gazette) {
    _gazette = gazette;
    notifyListeners();
  }

  fetchLatestGazette() async {
    setGazette(Resource.loading(data: _gazette.data));
    try {
      final _gazette = await gazetteRepository.fetchLatest();
      setGazette(Resource.complete(_gazette));
      LOGGER.d(_gazette?.normatives);
    } catch (e) {
      LOGGER.e(e);
      setGazette(Resource.error(e.toString(), data: _gazette.data));
    }
  }
}
