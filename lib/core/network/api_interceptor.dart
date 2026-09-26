import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import '../constants/api_endpoints.dart';
import '../services/storage_service.dart';

class ApiInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;

  ApiInterceptor(this._dio);

  StorageService get _storage => g.Get.find<StorageService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      final refreshToken = _storage.getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        _isRefreshing = true;
        try {
          final refreshResponse = await Dio().post(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.refreshToken}',
            data: {'refreshToken': refreshToken},
          );

          if (refreshResponse.statusCode == 200 && refreshResponse.data['success'] == true) {
            final newAccessToken = refreshResponse.data['data']['tokens']['accessToken'];
            final newRefreshToken = refreshResponse.data['data']['tokens']['refreshToken'];

            await _storage.saveAccessToken(newAccessToken);
            await _storage.saveRefreshToken(newRefreshToken);

            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newAccessToken';

            final cloneReq = await _dio.fetch(options);
            _isRefreshing = false;
            return handler.resolve(cloneReq);
          }
        } catch (_) {
          _isRefreshing = false;
          await _storage.clearAuthData();
        }
      }
    }
    handler.next(err);
  }
}
