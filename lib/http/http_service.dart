import 'package:dio/dio.dart';

class SingletonHttpService {
  static final SingletonHttpService _instance =
      SingletonHttpService._internal();
  final Dio _dio = Dio();

  factory SingletonHttpService() {
    return _instance;
  }

  SingletonHttpService._internal() {
    // 配置 Dio 实例
    _dio.options.baseUrl = 'https://api.example.com';
    _dio.options.connectTimeout = Duration(milliseconds: 5000); // 连接超时时间
    _dio.options.receiveTimeout = Duration(milliseconds: 5000); // 接收超时时间
    _dio.options.responseType = ResponseType.json;
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    _dio.options.contentType = 'application/json; charset=utf-8';
  }

  Future<Response> getRequest(String endpoint) async {
    try {
      Response response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      // 处理请求错误
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      // 处理请求错误
      throw Exception('Failed to post data: $e');
    }
  }
}
