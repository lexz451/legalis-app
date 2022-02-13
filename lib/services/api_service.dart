import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:legalis/model/error.dart';

class ApiService {
  var dio = Dio(BaseOptions(
    baseUrl: "https://api-gaceta.datalis.dev/api/",
    //connectTimeout: 20000,
    //receiveTimeout: 3000,
  ))
    ..interceptors.add(DioCacheManager(CacheConfig()).interceptor);

  Future<T?> get<T>(String path, {Map<String, String>? params}) async {
    try {
      final res = await dio.get<T>(path,
          queryParameters: params,
          options: buildCacheOptions(Duration(days: 1)));
      return res.data;
    } on DioError catch (e) {
      throw Error(message: e.message);
    }
  }
}
