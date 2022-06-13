import 'package:dio/dio.dart';

class EncodingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.queryParameters.isEmpty) {
      super.onRequest(options, handler);
      return;
    }
    final params = _encodeParams(options.queryParameters);
    handler.next(options.copyWith(queryParameters: params));
  }

  _quote(value) => value.toString().contains(" ") ? "'$value'" : value;

  Map<String, dynamic> _encodeParams(Map<String, dynamic> params) {
    return {
      ...params,
      'organism': _quote(params['organism']),
      'tematica': _quote(params['tematica']),
      'state': _quote(params['state'])
    };
  }
}
