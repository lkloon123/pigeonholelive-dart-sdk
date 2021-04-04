import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('unauthorized exception test', () {
    test('should show correct msg', () {
      var validationError = [
        ValidationError(field: 'name', message: 'required')
      ];
      var validationErrors =
          ValidationErrors(message: '', errors: validationError);
      var exception = ValidationException(
        validationErrors: validationErrors,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, '');
      expect(
        exception.toString(),
        'ValidationException: ValidationErrors ${jsonEncode(validationErrors.toJson())}',
      );

      validationErrors = ValidationErrors(
        message: 'validation error',
        errors: validationError,
      );
      exception = ValidationException(
        msg: 'validation msg',
        validationErrors: validationErrors,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, 'validation msg');
      expect(
        exception.toString(),
        'ValidationException: ValidationErrors ${jsonEncode(validationErrors.toJson())}',
      );
    });
  });
}
