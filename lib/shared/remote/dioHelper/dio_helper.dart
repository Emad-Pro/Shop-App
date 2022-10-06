import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:my_app_shop/shared/remote/endpoint.dart';

class DioHelper {
  static Dio? dio;

  static init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
    //fix problem In Mobile
    (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    print("DIO Successfuly");
    //fix problem In Mobile
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? qurey,
    String Language = 'ar',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': Language,
      'Authorization': token ?? ''
    };
    return await dio?.get(
      url,
      queryParameters: qurey ?? null,
    );
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? qurey,
      String Language = 'ar',
      String? token,
      required Map<String, dynamic> data}) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
      'lang': Language,
      'Content-Type': 'application/json',
    };

    return dio!.post(url, queryParameters: qurey, data: data);
  }

  static Future<Response> deleteData(
      {required String url,
      Map<String, dynamic>? qurey,
      String Language = 'ar',
      String? token}) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
      'lang': Language,
      'Content-Type': 'application/json',
    };

    return dio!.delete(url, queryParameters: qurey);
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? qurey,
      String Language = 'ar',
      String? token,
      required Map<String, dynamic> data}) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
      'lang': Language,
      'Content-Type': 'application/json',
    };

    return dio!.put(url, queryParameters: qurey, data: data);
  }
}
