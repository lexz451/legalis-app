import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/normative_state.dart';
import 'package:legalis/model/normative_thematic.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/download_repository.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/utils/base_model.dart';
import 'package:legalis/repositories/bookmarks_repository.dart';

class AppViewModel extends BaseModel {
  final bookmarksRepository = getIt<BookmarksRepository>();
  final normativeRepository = getIt<NormativeRepository>();
  final downloadRepository = getIt<DownloadRepository>();

  Resource<List<NormativeState>> _states = Resource.loading();
  Resource<List<NormativeState>> get states => _states;
  setStates(Resource<List<NormativeState>> states) {
    _states = states;
    notifyListeners();
  }

  Resource<List<NormativeThematic>> _thematics = Resource.loading();
  Resource<List<NormativeThematic>> get thematics => _thematics;
  setThematics(Resource<List<NormativeThematic>> thematics) {
    _thematics = thematics;
    notifyListeners();
  }

  Resource<List<String>> _organisms = Resource.loading();
  Resource<List<String>> get organisms => _organisms;
  setOrganisms(Resource<List<String>> orgs) {
    _organisms = orgs;
    notifyListeners();
  }

  Resource<List<Normative>> _bookmarks = Resource.loading();
  Resource<List<Normative>> get bookmarks => _bookmarks;
  setBookmarks(Resource<List<Normative>> norms) {
    _bookmarks = norms;
    notifyListeners();
  }

  Resource<List<File>> _downloads = Resource.loading();
  Resource<List<File>> get downloads => _downloads;
  setDownloads(Resource<List<File>> downloads) {
    _downloads = downloads;
    notifyListeners();
  }

  removeDownload(File file) async {
    await downloadRepository.remove(file);
    fetchDownloads();
    notifyListeners();
  }

  Future<bool> isDownloaded(fileName) async {
    return await downloadRepository.isDownloaded(fileName);
  }

  Future saveFile(url, fileName) async {
    await downloadRepository.downloadFile(url, fileName);
    fetchDownloads();
    notifyListeners();
  }

  bool isBookmark(Normative norm) => bookmarksRepository.isInBookmarks(norm);

  toggleBookmark(Normative norm) {
    if (isBookmark(norm)) {
      _removeBookmark(norm);
    } else {
      _addBookmark(norm);
    }
    notifyListeners();
  }

  _addBookmark(norm) {
    bookmarksRepository.addToBookmarks(norm);
    fetchBookmarks();
  }

  _removeBookmark(norm) {
    bookmarksRepository.removeFromBookmarks(norm);
    fetchBookmarks();
  }

  Future fetchDownloads() async {
    setDownloads(Resource.loading(data: _downloads.data));
    try {
      final _res = await downloadRepository.getDownloadedFiles();
      setDownloads(Resource.complete(_res));
    } catch (e) {
      LOGGER.e(e);
      setDownloads(Resource.error(e.toString(), data: _downloads.data));
    }
  }

  Future fetchBookmarks() async {
    setBookmarks(Resource.loading(data: _bookmarks.data));
    try {
      final _res = await bookmarksRepository.getBookmarks();
      setBookmarks(Resource.complete(_res));
    } catch (e) {
      LOGGER.e(e);
      setBookmarks(Resource.error(e.toString(), data: _bookmarks.data));
    }
  }

  Future fetchStates() async {
    setStates(Resource.loading(data: _states.data));
    try {
      final _res = await normativeRepository.getNormativeStates();
      setStates(Resource.complete(_res));
    } catch (e) {
      LOGGER.e(e);
      setStates(Resource.error(e.toString(), data: _states.data));
    }
  }

  Future fetchThematics() async {
    setThematics(Resource.loading(data: _thematics.data));
    try {
      final _res = await normativeRepository.getNormativeThematics();
      setThematics(Resource.complete(_res));
    } catch (e) {
      LOGGER.e(e);
      setThematics(Resource.error(e.toString(), data: _thematics.data));
    }
  }

  Future fetchOrganisms() async {
    setOrganisms(Resource.loading(data: _organisms.data));
    try {
      final _res = await normativeRepository.getNormativeOrganisms();
      setOrganisms(Resource.complete(_res));
    } catch (e) {
      LOGGER.e(e);
      setOrganisms(Resource.error(e.toString(), data: _organisms.data));
    }
  }

  init() async {
    setLoading(true);
    try {
      await Future.wait([
        fetchBookmarks(),
        fetchDownloads(),
        fetchOrganisms(),
        fetchStates(),
        fetchThematics()
      ]);
      setLoading(false);
    } catch (e) {
      LOGGER.e(e);
      setError(e);
      setLoading(false);
    }
  }
}
