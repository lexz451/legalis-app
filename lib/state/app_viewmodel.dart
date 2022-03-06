import 'package:get_it/get_it.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/utils/base_model.dart';
import 'package:legalis/repositories/bookmarks_repository.dart';

class AppViewModel extends BaseModel {
  final bookmarksRepository = GetIt.I<BookmarksRepository>();

  Resource<List<Normative>> _bookmarks = Resource.loading();

  Resource<List<Normative>> get bookmarks => _bookmarks;
  set bookmarks(Resource<List<Normative>> norms) {
    _bookmarks = norms;
    notifyListeners();
  }

  bool isSaved(norm) => bookmarksRepository.isInBookmarks(norm);

  toggleIsSaved(norm) {
    if (isSaved(norm)) {
      removeBookmark(norm);
    } else {
      addBookmark(norm);
    }
    notifyListeners();
  }

  addBookmark(norm) {
    bookmarksRepository.addToBookmarks(norm);
    loadBookmarks();
  }

  removeBookmark(norm) {
    bookmarksRepository.removeFromBookmarks(norm);
    loadBookmarks();
  }

  loadBookmarks() async {
    bookmarks = Resource.loading();
    try {
      final _bookmarks = await bookmarksRepository.getBookmarks();
      bookmarks = Resource.complete(_bookmarks);
    } catch (e) {
      bookmarks = Resource.error(e.toString());
    }
  }
}
