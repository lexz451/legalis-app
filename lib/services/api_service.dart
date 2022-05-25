import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:legalis/main.dart';
import 'package:path_provider/path_provider.dart';

class APIService {
  // ignore: non_constant_identifier_names
  final API_URL = "https://api-gaceta.datalis.dev/api";
  final dio = Dio();

  late CacheOptions options;

  Future<APIService> init() async {
    final _temp = await _getTempDirectory();
    final _store = HiveCacheStore(_temp?.path);
    options = CacheOptions(
      store: _store,
      policy: CachePolicy.forceCache,
    );
    dio.options.baseUrl = API_URL;
    dio.interceptors.add(DioCacheInterceptor(options: options));
    return this;
  }

  Future<Directory?> _getTempDirectory() async {
    Directory? _tmpDir;
    if (!kIsWeb) {
      _tmpDir = await getTemporaryDirectory();
    }
    return _tmpDir;
  }

  Future get(String path,
      {Map<String, dynamic>? params, refresh = true}) async {
    try {
      //inal policy = refresh ? CachePolicy.refresh : CachePolicy.forceCache;
      final _res = await dio.get(path,
          queryParameters: params,
          options: options.copyWith(policy: CachePolicy.noCache).toOptions());
      return _res.data;
    } on DioError catch (e) {
      LOGGER.e(e.requestOptions.uri.toString());
      LOGGER.e(e.message);
    }
  }

  Future download(String url, String savePath) async {
    try {
      return dio.download(url, savePath);
    } on DioError catch (e) {
      LOGGER.e(e);
    }
  }
}
