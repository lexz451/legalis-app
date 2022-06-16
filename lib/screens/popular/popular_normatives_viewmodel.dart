import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/utils/base_model.dart';

class PopularNormativeViewModel extends BaseModel {
  final normativeRepository = getIt<NormativeRepository>();

  Resource<List<Normative>> popular = Resource.loading();

  setPopularNormative(norms) {
    popular = norms;
    notifyListeners();
  }

  fetchPopularNorms() async {
    setPopularNormative(Resource.loading(data: popular.data));
    try {
      final res = await normativeRepository.fetchPopularNormatives();
      setPopularNormative(Resource.complete(res));
    } catch (e) {
      LOGGER.e(e);
      setPopularNormative(Resource.error(e.toString(), data: popular.data));
    }
  }
}
