import 'package:dio/dio.dart';

import 'api_client.dart';

class DioClient extends ApiClient {
  Dio dio;

  DioClient(this.dio);

  @override
  Future<Response<T>> delete<T>(String path,
      {data,
      Map<String, dynamic> queryParameters,
      Map<String, String> headers}) async {
    Options options = Options(headers: headers);
    Response<T> response = await dio.delete(path = path,
        data: data, queryParameters: queryParameters, options: options);
    return response;
  }

  @override
  Future<Response<T>> get<T>(String path, Map<String, dynamic> queryParameters,
      Map<String, String> headers,
      {Options options}) async {
    Response<T> response = await dio.get(path = path,
        queryParameters: queryParameters, options: options);
    return response;
  }

  @override
  Future<Response<T>> post<T>(String path,
      {data, Map<String, String> headers, Options options}) async {
    if (options == null) options = Options(headers: headers);
    Response<T> response =
        await dio.post(path = path, data: data, options: options);
    return response;
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Map<String, String> headers,
  }) async {
    Options options = Options(headers: headers);
    Response<T> response = await dio.put(path = path,
        data: data, queryParameters: queryParameters, options: options);
    return response;
  }
}
