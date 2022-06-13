import 'package:get_it/get_it.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/services/storage_service.dart';

class BookmarksRepository {
  final localStorageService = GetIt.I<StorageService>();

  Future<List<Normative>> getBookmarks() async {
    final bookmarks = localStorageService.getItem('bookmarks');
    if (bookmarks == null) return [];
    return List<Normative>.from(bookmarks.map((e) => Normative.fromMap(e)));
  }

  Future<bool> addToBookmarks(Normative normative) async {
    final bookmarks = localStorageService.getItem('bookmarks') ?? [];
    bookmarks.add(normative.toMap());
    return localStorageService.saveItem('bookmarks', bookmarks);
  }

  Future<bool> removeFromBookmarks(Normative normative) {
    final bookmarks =
        (localStorageService.getItem('bookmarks') ?? []) as List<dynamic>;
    bookmarks.removeWhere((e) => e['id'] == normative.id);
    return localStorageService.saveItem('bookmarks', bookmarks);
  }

  bool isInBookmarks(Normative normative) {
    final bookmarks =
        (localStorageService.getItem('bookmarks') ?? []) as List<dynamic>;
    return bookmarks.where((e) => e['id'] == normative.id).isNotEmpty;
  }
}
