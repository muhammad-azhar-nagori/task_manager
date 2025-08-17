import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  /// Generic GET request
  Future<T> get<T>(String url, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get<T>(url, queryParameters: queryParams);
      _validateResponse(response);
      return response.data as T;
    } on DioException catch (e) {
      throw ApiException(_handleDioError(e));
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  /// Generic POST request
  Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(url, data: data);
      _validateResponse(response);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException(_handleDioError(e));
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  void _validateResponse(Response response) {
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      throw ApiException(
          'API Error: ${response.statusCode} ${response.statusMessage}');
    }
  }

  /// Map DioError to readable message
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Request send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Received invalid status: ${e.response?.statusCode} | ${e.response?.statusMessage}';
      case DioExceptionType.cancel:
        return 'Request canceled';
      case DioExceptionType.unknown:
      default:
        return 'Error: ${e.message}';
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
