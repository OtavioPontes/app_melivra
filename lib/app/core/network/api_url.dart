// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class Api {
  static const String url = 'http://192.168.1.19:8080';

  static Future<void> test() async {
    try {
      final result = await Dio().post(
        "$url/auth/",
        options: Options(receiveTimeout: 5000),
        data: {
          "email": "otavio.pontes1103@gmail.com",
          "password": "12345",
        },
      );
      print(result.data);
    } catch (e) {
      print(e);
    }
  }
}
