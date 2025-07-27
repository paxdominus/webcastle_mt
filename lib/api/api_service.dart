import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._privateConstructor();
  factory ApiService() => _instance;

  late Dio _dio;

  final String baseUrl =
      "https://s419.previewbay.com/fragrance-b2b-backend/api/v1";

  String token = "";

  ApiService._privateConstructor() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic> params = const {},
  }) async {
    try {
      final response = await _dio.get(
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        endpoint,
        queryParameters: params,
      );
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic> params = const {},
  }) async {
    try {
      final response = await _dio.post(endpoint, queryParameters: params);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
