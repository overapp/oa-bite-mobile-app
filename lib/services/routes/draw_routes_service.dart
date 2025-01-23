import 'dart:developer';
import 'package:bite/models/network_response/network_response.dart';
import 'package:bite/models/request_type/request_type.dart';
import 'package:dio/dio.dart';
import 'package:bite/constants/constants.dart' as constants;

/// Service to manage Google Direction HTTP request.
class RoutesApi {
  // Initialize Dio
  final dio = createDio();

  // The private constructor is called only once to create the Singleton instance.
  RoutesApi._internal();

  // We implement the Singleton pattern to ensure that only one instance of
  // BluetoothManager is created and used throughout the entire application.
  static final _instance = RoutesApi._internal();

  // The factory constructor returns the already existing instance, ensuring
  // that there are not multiple BluetoothManager objects floating around.
  factory RoutesApi() => _instance;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: "https://maps.googleapis.com/maps/api/directions/json?origin=",
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

  // Generic API call method
  Future<NetworkResponse> request({
    required String url,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Function(dynamic data)? fromJson,
  }) async {
    late Response<dynamic> result;

    final Options options = Options(headers: headers);

    try {
      switch (requestType) {
        case RequestType.GET:
          result = await dio.get(url,
              queryParameters: queryParameters, options: options);
          break;
        case RequestType.POST:
          result = await dio.post(url,
              data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.PUT:
          result = await dio.put(url,
              data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.DELETE:
          result = await dio.delete(url,
              data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.PATCH:
          result = await dio.patch(url,
              data: body, queryParameters: queryParameters, options: options);
          break;
      }

      return NetworkResponse.onSuccess(
          result.data, result.statusCode.toString(), result.statusMessage);
    } on DioException catch (error) {
      // Error management
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
          'UNKNOW',
          error.message ?? '',
        );
      default:
        return NetworkResponse.onError(
          'UNKNOW',
          error.message ?? '',
        );
    }
  }
}
