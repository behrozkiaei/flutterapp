import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paytel/const.dart';

class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();

  factory DioSingleton() {
    return _singleton;
  }

  DioSingleton._internal();
  
  static BaseOptions options = BaseOptions(
    baseUrl: Config.baseUrl,
    headers: {'Content-Type': 'application/json' ,}
  );
  static Dio dio = Dio(options);

  static void init() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Intercept request before it is sent
          // Add any headers, query parameters or modify the request as needed
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Intercept response before it is returned
          // Add any data processing or modification needed here
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}
