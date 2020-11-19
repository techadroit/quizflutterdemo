import 'package:dio/dio.dart';

abstract class ApiClient {
  Future<Response<T>> get<T>(String path, Map<String, dynamic> queryParameters,
      Map<String, String> headers,
      {Options options});

  Future<Response<T>> post<T>(String path,
      {data, Map<String, String> headers, Options options});

  Future<Response<T>> put<T>(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        Map<String, String> headers,
      });

  Future<Response<T>> delete<T>(String path,
      {data,
        Map<String, dynamic> queryParameters,
        Map<String, String> headers});
}