import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/src/models/errors/pigeonhole_error.dart';

class PigeonholeException extends DioError {
  final String? msg;
  final PigeonholeError pigeonholeError;

  PigeonholeException({
    this.msg = '',
    required this.pigeonholeError,
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic? error,
  }) : super(
    requestOptions: requestOptions,
    response: response,
    type: type,
    error: error,
  );

  @override
  String get message => msg ?? '';

  @override
  String toString() => 'PigeonholeException: $pigeonholeError';
}
