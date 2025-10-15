part of '../dio_config.dart';

class RequestInterceptor extends Interceptor {
  RequestInterceptor(this.dio, this.headers);
  final Dio dio;
  final Map<String, String> headers;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }
}
