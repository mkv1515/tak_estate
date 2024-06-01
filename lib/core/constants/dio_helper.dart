import 'package:dio/dio.dart';
import 'package:tak/core/constants/constants.dart';

var headers = {'Content-Type': 'application/json'};

final Dio dio = Dio(
  BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 10),
      headers: headers),
);
