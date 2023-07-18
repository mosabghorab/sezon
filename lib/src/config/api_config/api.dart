import 'package:sezon/src/config/api_config/interceptors/custom_interceptor.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:dio/dio.dart';

class Api {
  static final Dio dio = Dio(BaseOptions(
      baseUrl: Constants.apiUrl,
      receiveTimeout: 15000,
      connectTimeout: 15000,
      sendTimeout: 15000,
      contentType: Headers.jsonContentType,
      validateStatus: (status) {
        return true;
      },
      headers: {
        'Accept': 'application/json',
      }))
    ..interceptors.add(CustomInterceptor());
}
