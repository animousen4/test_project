import 'package:dio/dio.dart';

class ApiProvider {
  const ApiProvider(Dio dio) : _dio = dio;
  // ignore: unused_field
  final Dio _dio;
}
