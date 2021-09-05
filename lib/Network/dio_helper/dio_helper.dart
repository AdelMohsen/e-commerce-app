import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  static init() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? quires,
      String? token ,
      String? lang}) async {
    _dio.options.headers = {
      'Authorization': token ?? '',
      'lang': lang,
      'Content-Type': 'application/json'
    };
    return await _dio.get(url, queryParameters: quires);
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      String? token ,
      String? lang}) async {
    _dio.options.headers = {
      'Authorization': token ?? '',
      'lang': lang,
      'Content-Type': 'application/json'
    };
    return await _dio.post(url, data: data);
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? quires,
      required Map<String, dynamic> data,
      String? token,
      String? lang}) async {
    _dio.options.headers = {
      'Authorization': token ?? '',
      'lang': lang,
      'Content-Type': 'application/json'
    };
    return await _dio.put(url, queryParameters: quires, data: data);
  }
}
