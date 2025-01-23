import 'dart:developer';
import 'package:bite/models/network_response/network_response.dart';
import 'package:bite/models/request_type/request_type.dart';
import 'package:dio/dio.dart';
import 'package:bite/constants/constants.dart' as constants;

/// Service to manage HTTP requests for uploading images.
class UploadImage {
  final dio = createDio();

  UploadImage._internal();

  static final _singleton = UploadImage._internal();

  factory UploadImage() => _singleton;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        receiveTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );

    if (constants.Http.debug) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (o) => log('HTTP ${o.toString()}'),
        ),
      );
    }

    return dio;
  }

  Future<NetworkResponse> request({
    required String url,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
    Function(dynamic data)? fromJson,
  }) async {
    late Response<dynamic> result;

    final Options options = Options(
      headers: headers,
      validateStatus: (status) => status! < 500,
    );

    try {
      switch (requestType) {
        case RequestType.PUT:
          result = await dio.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: options,
          );
          break;

        default:
          throw UnsupportedError('Request type not supported in this context');
      }

      return NetworkResponse.onSuccess(
          result, result.statusCode.toString(), result.statusMessage);
    } on DioException catch (error) {
      return _handleDioError(error);
    }
  }

  NetworkResponse _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkResponse.onError(
          'CONNECTION TIMEOUT',
          error.message ?? '',
        );
      case DioExceptionType.sendTimeout:
        return NetworkResponse.onError(
          'SEND TIMEOUT',
          error.message ?? '',
        );
      case DioExceptionType.receiveTimeout:
        return NetworkResponse.onError(
          'RECEIVE TIMEOUT',
          error.message ?? '',
        );
      case DioExceptionType.badResponse:
        return NetworkResponse.onError(
          'BAD RESPONSE',
          error.message ?? '',
        );
      case DioExceptionType.cancel:
        return NetworkResponse.onError(
          'CANCEL',
          error.message ?? '',
        );
      case DioExceptionType.unknown:
        return NetworkResponse.onError(
          'UNKNOWN',
          error.message ?? '',
        );
      default:
        return NetworkResponse.onError(
          'UNKNOWN',
          error.message ?? '',
        );
    }
  }
}
