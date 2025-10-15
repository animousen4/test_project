part of '../dio_config.dart';

class ResponseInterceptor extends Interceptor {
  ResponseInterceptor(this.dio);
  final Dio dio;

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    //TODO: TEMPORARY SOLUTION DELETE ONCE NEW IMPLEMENTED
    // Logger.responseLogger(response);
    handler.next(response);
  }
}
