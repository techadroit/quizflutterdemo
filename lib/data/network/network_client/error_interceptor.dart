import 'dart:io';

import 'package:dio/dio.dart';

import '../../datasource/exceptoins.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err) {
    if (err.error is AppException) {
      throw err.error;
    } else if (err.type == DioErrorType.RESPONSE) {
      if (err.response.statusCode == 404) {
        throw NoQuestionFound();
      }
    }else if(err.type == DioErrorType.DEFAULT){
      if(err.error is SocketException){
        throw NoNetworkException();
      }
    }else{
      super.onError(err);
    }
    throw UnknownException();
  }
}
