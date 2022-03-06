import 'package:get_it/get_it.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/gazette_type.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/model/topic.dart';
import 'package:legalis/repositories/gazette_repository.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/utils/base_model.dart';

class GazettesViewModel extends BaseModel {
  final gazetteRepository = GetIt.I<GazetteRepository>();
  final normativeRepository = GetIt.I<NormativeRepository>();

  List<GazetteType> _types = [];
  List<Topic> _topics = [];

  bool _filtersLoading = true;

  Resource<Paged<Gazette>> _gazettes = Resource.loading();

  bool get filtersLoading => _filtersLoading;
  set filtersLoading(bool loading) {
    _filtersLoading = loading;
    notifyListeners();
  }

  Resource<Paged<Gazette>> get gazettes {
    return _gazettes;
  }

  set gazettes(Resource<Paged<Gazette>> gazettes) {
    _gazettes = gazettes;
    notifyListeners();
  }

  List<GazetteType> get gazetteTypes {
    return _types;
  }

  set gazetteTypes(List<GazetteType> types) {
    _types = types;
  }

  List<Topic> get normativeTopics {
    return _topics;
  }

  set normativeTopics(List<Topic> topics) {
    _topics = topics;
  }

  loadFilterData() async {
    filtersLoading = true;
    final _topics = await normativeRepository.fetchNormativeTopics();
    final _types = await gazetteRepository.fetchTypes();
    normativeTopics = _topics.sublist(0, 10);
    gazetteTypes = _types;
    filtersLoading = false;
    loadGazettes();
  }

  loadGazettes({params = const {}}) async {
    gazettes = Resource.loading();
    try {
      final _gazettes = await gazetteRepository.fetchAll(params: params);
      gazettes = Resource.complete(_gazettes);
    } catch (e) {
      gazettes = Resource.error(e.toString());
    }
  }
}
