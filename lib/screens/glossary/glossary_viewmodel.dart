import 'package:get_it/get_it.dart';
import 'package:legalis/model/glossary_term.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/glossary_repository.dart';
import 'package:legalis/utils/base_model.dart';

class GlossaryViewModel extends BaseModel {
  final glossaryRepository = GetIt.I<GlossaryRepository>();

  Resource<Paged<GlossaryTerm>> _terms = Resource.loading();

  Resource<Paged<GlossaryTerm>> get terms {
    return _terms;
  }

  set terms(Resource<Paged<GlossaryTerm>> terms) {
    _terms = terms;
    notifyListeners();
  }

  loadTerms({String letter = 'A'}) async {
    terms = Resource.loading(data: _terms.data);
    try {
      final _terms = await glossaryRepository.fetchTerms();
      terms = Resource.complete(_terms);
    } catch (e) {
      terms = Resource.error(e.toString(), data: _terms.data);
    }
  }
}
