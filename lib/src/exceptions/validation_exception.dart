import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/src/exceptions/pigeonhole_exception.dart';
import 'package:pigeonholelive_sdk/src/models/errors/validation_errors.dart';

class ValidationException extends PigeonholeException {
  final ValidationErrors validationErrors;

  ValidationException({
    String? msg = '',
    required this.validationErrors,
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic? error,
  }) : super(
          msg: msg,
          pigeonholeError: validationErrors,
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );

  @override
  String get message => msg ?? '';

  @override
  String toString() => 'ValidationException: $validationErrors';
}
