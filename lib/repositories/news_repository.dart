import 'package:legalis/di.dart';
import 'package:legalis/services/api_service.dart';

class NewsRepository {
  final apiService = getIt<APIService>();

  Future<List> fetchRecentNews() async {
    final res = await apiService.get(
        "https://api.eltoque.com/posts?categories=600c46c1929b80000d284502&_sort=publish_date:DESC&_limit=5");
    return List.from(res);
  }
}
