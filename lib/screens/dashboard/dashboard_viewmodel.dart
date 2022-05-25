import 'package:dio/dio.dart';
import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/news_repository.dart';
import 'package:legalis/services/api_service.dart';
import 'package:legalis/utils/base_model.dart';

class DashboardViewModel extends BaseModel {
  final newsRepository = getIt<NewsRepository>();

  Resource<List> _news = Resource.loading();

  List get news => _news.data ?? [];
  bool get isLoading => _news.state == ResourceState.loading;

  setNews(news) {
    _news = news;
    notifyListeners();
  }

  fetchNews() async {
    setNews(Resource.loading(data: _news.data));
    try {
      final _res = await newsRepository.fetchRecentNews();
      setNews(Resource.complete(_res));
    } catch (e) {
      LOGGER.e(e);
      setNews(Resource.error(e.toString(), data: _news.data));
    }
  }
}
