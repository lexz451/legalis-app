import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
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
      final _norm = await normativeRepository.fetchById(id);
      final _gazette = await gazetteRepository.fetchById(_norm.gazette);
      gazette = _gazette;
      normative = Resource.complete(_norm);
      setLoading(false);
    } catch (e) {
      normative = Resource.error(e.toString());
      setLoading(false);
    }
  }
}
