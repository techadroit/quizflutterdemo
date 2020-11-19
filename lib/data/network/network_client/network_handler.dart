import 'package:TataEdgeDemo/data/network/network_client/api_client.dart';
import 'package:TataEdgeDemo/data/network/network_client/error_interceptor.dart';
import 'package:dio/dio.dart';

import 'dio_client.dart';

class NetworkHandler {
  static NetworkHandler _instance;
  Dio dio = new Dio();

  factory NetworkHandler({bool isDebugMode}) {
    _instance ??= NetworkHandler._internal(isDebugMode);
    return _instance;
  }

  NetworkHandler._internal(bool isDebugMode) {
    dio.options.baseUrl = "https://quizapi.io/";
    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      options = await HeaderInterceptor().intercept(options);
      return options;
    }));
    if (isDebugMode) dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(ErrorInterceptor());
  }

  ApiClient getClient() => DioClient(dio);

  static NetworkHandler get instance {
    return _instance;
  }
}

class HeaderInterceptor {
  Future<RequestOptions> intercept(Options options) async {
    options.headers["X-Api-Key"] = "QCr3sI3fhyQ5yq9huYVYr2Zsp3pH6Pjyb3Uaq2NX";
    return options;
  }
}
