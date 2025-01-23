import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_response.freezed.dart';

@freezed

// A generic network response class that implements success, error and
// loading scenarios
class NetworkResponse with _$NetworkResponse {
  const factory NetworkResponse.onSuccess(dynamic data, String status, String? message) = Ok;
  const factory NetworkResponse.onError(
       String status, String message) = ERROR;
  const factory NetworkResponse.loading(String message) = LOADING;
}
