import 'package:get_it/get_it.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/services/localstorage_service.dart';

class BookmarksRepository {
  final localStorageService = GetIt.I<LocalStorageService>();

  Future<List<Normative>> getBookmarks() async {
    final _bookmarks = localStorageService.getItem('bookmarks');
    if (_bookmarks == null) return [];
    return List<Normative>.from(_bookmarks.map((e) => Normative.fromMap(e)));
  }

  Future<bool> addToBookmarks(Normative normative) async {
    final _bookmarks = localStorageService.getItem('bookmarks') ?? [];
    _bookmarks.add(normative.toMap());
    return localStorageService.saveItem('bookmarks', _bookmarks);
  }

  Future<bool> removeFromBookmarks(Normative normative) {
    final _bookmarks =
        (localStorageService.getItem('bookmarks') ?? []) as List<dynamic>;
    _bookmarks.removeWhere((e) => e['id'] == normative.id);
    return localStorageService.saveItem('bookmarks', _bookmarks);
  }

  bool isInBookmarks(Normative normative) {
    final _bookmarks =
        (localStorageService.getItem('bookmarks') ?? []) as List<dynamic>;
    return _bookmarks.where((e) => e['id'] == normative.id).isNotEmpty;
  }
}
