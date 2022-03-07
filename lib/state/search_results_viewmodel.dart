import 'package:get_it/get_it.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/utils/base_model.dart';

class SearchResultsViewModel extends BaseModel {
  final normativeRepository = GetIt.I<NormativeRepository>();

  Resource<Paged<Normative>> _results = Resource.loading();

  List<Normative> get norms => _results.data?.results ?? [];
  bool get isLoading => _results.state == ResourceState.loading;
  bool get hasErrors => _results.state == ResourceState.error;
  String get error => _results.exception ?? "Unknown exception";

  setResults(Resource<Paged<Normative>> res) {
    _results = res;
    notifyListeners();
  }

  Future<void> fetchResults(Map<String, dynamic> params) async {
    setResults(Resource.loading());
    try {
      final _res = await normativeRepository.searchNormatives(params);
      setResults(Resource.complete(_res));
    } catch (e) {
      setResults(Resource.error(e.toString()));
    }
  }
}
