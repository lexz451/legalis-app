import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:legalis/main.dart';
import 'package:legalis/utils/encoding_interceptor.dart';
import 'package:path_provider/path_provider.dart';

class APIService {
  // ignore: non_constant_identifier_names
  final API_URL = "https://api-gaceta.datalis.dev/api";
  final dio = Dio();

  late CacheOptions options;

  Future<APIService> init() async {
    final temp = await _getTempDirectory();
    final store = HiveCacheStore(temp?.path);
    options = CacheOptions(
      store: store,
      policy: CachePolicy.forceCache,
    );
    dio.options.baseUrl = API_URL;
    dio.interceptors.add(EncodingInterceptor());
    dio.interceptors.add(DioCacheInterceptor(options: options));

    return this;
  }

  Future<Directory?> _getTempDirectory() async {
    Directory? tmpDir;
    if (!kIsWeb) {
      tmpDir = await getTemporaryDirectory();
    }
    return tmpDir;
  }

  Future get(String path,
      {Map<String, dynamic>? params, refresh = false}) async {
    try {
      final policy = refresh ? CachePolicy.refresh : CachePolicy.forceCache;
      final res = await dio.get(path,
          queryParameters: params,
          options: options.copyWith(policy: policy).toOptions());
      return res.data;
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
