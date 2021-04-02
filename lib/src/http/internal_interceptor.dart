import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/src/auth/auth_interface.dart';
import 'package:pigeonholelive_sdk/src/exceptions/not_found_exception.dart';
import 'package:pigeonholelive_sdk/src/exceptions/pigeonhole_exception.dart';
import 'package:pigeonholelive_sdk/src/exceptions/rate_limited_exception.dart';
import 'package:pigeonholelive_sdk/src/exceptions/server_exception.dart';
import 'package:pigeonholelive_sdk/src/exceptions/throttling_exception.dart';
import 'package:pigeonholelive_sdk/src/exceptions/unauthorized_exception.dart';
import 'package:pigeonholelive_sdk/src/exceptions/validation_exception.dart';
import 'package:pigeonholelive_sdk/src/models/errors/pigeonhole_error.dart';
import 'package:pigeonholelive_sdk/src/models/errors/validation_errors.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';

class InternalInterceptor extends Interceptor {
  AuthInterface get auth => ServiceProviderManager.instance.getIt.get<AuthInterface>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(auth.buildAuth(options));
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.response &&
        err.response?.data != null &&
        err.response?.data is Map) {
      var pigeonholeError = PigeonholeError.fromJson(err.response?.data);

      if (err.response?.statusCode == 401) {
        return handler.next(UnauthorizedException(
          msg: pigeonholeError.message,
          pigeonholeError: pigeonholeError,
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: err.error,
        ));
      }

      if (err.response?.statusCode == 404) {
        return handler.next(NotFoundException(
          msg: pigeonholeError.message,
          pigeonholeError: pigeonholeError,
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: err.error,
        ));
      }

      if (err.response?.statusCode == 422) {
        var validationErrors = ValidationErrors.fromJson(err.response?.data);
        return handler.next(ValidationException(
          msg: validationErrors.message,
          validationErrors: validationErrors,
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: err.error,
        ));
      }

      if (err.response?.statusCode == 429) {
        return handler.next(RateLimitedException(
          msg: pigeonholeError.message,
          pigeonholeError: pigeonholeError,
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: err.error,
        ));
      }

      if (err.response?.statusCode == 500) {
        return handler.next(ServerException(
          msg: pigeonholeError.message,
          pigeonholeError: pigeonholeError,
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: err.error,
        ));
      }

      if (err.response?.statusCode == 503) {
        return handler.next(ThrottlingException(
          msg: pigeonholeError.message,
          pigeonholeError: pigeonholeError,
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: err.error,
        ));
      }
    }

    var pigeonholeError = PigeonholeError(message: err.message);

    return handler.next(PigeonholeException(
      msg: pigeonholeError.message,
      pigeonholeError: pigeonholeError,
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
    ));
  }
}
