import 'package:get_it/get_it.dart';
import 'package:legalis/repositories/bookmarks_repository.dart';
import 'package:legalis/utils/base_model.dart';

class NormativeItemViewModel extends BaseModel {
  final bookmarksRepository = GetIt.I<BookmarksRepository>();

  bool isSaved(norm) => bookmarksRepository.isInBookmarks(norm);

  toggleIsSaved(norm) {
    if (isSaved(norm)) {
      bookmarksRepository.removeFromBookmarks(norm);
    } else {
      bookmarksRepository.addToBookmarks(norm);
    }
    notifyListeners();
  }
}
