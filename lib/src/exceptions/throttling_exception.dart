import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/src/exceptions/pigeonhole_exception.dart';
import 'package:pigeonholelive_sdk/src/models/errors/pigeonhole_error.dart';

class ThrottlingException extends PigeonholeException {
  ThrottlingException({
    String? msg = '',
    required PigeonholeError pigeonholeError,
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic? error,
  }) : super(
          msg: msg,
          pigeonholeError: pigeonholeError,
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );

  @override
  String get message => msg ?? '';

  @override
  String toString() => 'ThrottlingException: $pigeonholeError';
}