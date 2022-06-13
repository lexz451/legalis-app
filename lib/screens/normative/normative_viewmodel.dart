import 'package:legalis/di.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/bookmarks_repository.dart';
import 'package:legalis/repositories/download_repository.dart';
import 'package:legalis/repositories/gazette_repository.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/utils/base_model.dart';

class NormativeViewModel extends BaseModel {
  final normativeRepository = getIt<NormativeRepository>();
  final gazetteRepository = getIt<GazetteRepository>();
  final bookmarkRepository = getIt<BookmarksRepository>();
  final downloadRepository = getIt<DownloadRepository>();

  Gazette? _gazette;
  Resource<Normative> _norm = Resource.loading();
  bool _isDownloadingFile = false;

  bool get isDownloadingFile => _isDownloadingFile;
  set isDownloadingFile(bool isDownloading) {
    _isDownloadingFile = isDownloading;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  Gazette? get gazette => _gazette;
  set gazette(Gazette? gazette) {
    _gazette = gazette;
  }

  Resource<Normative> get normative {
    return _norm;
  }

  set normative(Resource<Normative> norm) {
    _norm = norm;
    notifyListeners();
  }

  /*Future<bool> isDownloaded(fileName) async {
    return await downloadRepository.isDownloaded(fileName);
  }

  saveFile(url, fileName) async {
    setLoading(true);
    await downloadRepository.downloadFile(url, fileName);
    setLoading(false);
  }*/

  loadNormative(String id) async {
    setLoading(true);
    try {
      final norm = await normativeRepository.fetchById(id);
      final gaz = await gazetteRepository.fetchById(norm.gazette);
      gazette = gaz;
      normative = Resource.complete(norm);
      setLoading(false);
    } catch (e) {
      normative = Resource.error(e.toString());
      setLoading(false);
    }
  }
}
