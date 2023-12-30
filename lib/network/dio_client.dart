import 'package:dio/dio.dart';

import '../storage/storage_provider.dart';

class DioClient {
  static final _dio = Dio();

  static Future<Response<T>> getRequest<T>(String endPoint) async {
    final token = await StorageProvider.getUserToken();
    if (token!.isNotEmpty) {
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    } else {
      _dio.options.headers.remove('Authorization');
    }
    return await _dio.get(endPoint);
  }

  static Future<dynamic> postRequest<T>(
      String endPoint, String requestBody) async {
    final token = await StorageProvider.getUserToken();
    if (token!.isNotEmpty) {
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    } else {
      _dio.options.headers.remove('Authorization');
    }
    return (await _dio.post(endPoint, data: requestBody)).toString();
  }
}
