import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../constants/api_endpoints.dart';
import '../constants/app_constants.dart';
import 'api_interceptor.dart';

class ApiClient extends GetxService {
  late final Dio dio;

  Future<ApiClient> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: AppConstants.connectTimeoutSeconds),
        receiveTimeout: const Duration(seconds: AppConstants.receiveTimeoutSeconds),
      ),
    );

    dio.interceptors.add(ApiInterceptor(dio));
    return this;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> patch(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return dio.patch(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return dio.delete(path, data: data, queryParameters: queryParameters);
  }
}
