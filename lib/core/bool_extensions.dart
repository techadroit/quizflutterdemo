import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

extension BoolExtension on bool {
  bool then(VoidCallback callback) {
    return callback.call();
  }
}