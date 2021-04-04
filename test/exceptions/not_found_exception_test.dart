import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('not found exception test', () {
    test('should show correct msg', () {
      var pigeonholeError = PigeonholeError(message: '');
      var exception = NotFoundException(
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, '');
      expect(
        exception.toString(),
        'NotFoundException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );

      pigeonholeError = PigeonholeError(message: 'not found');
      exception = NotFoundException(
        msg: 'not found',
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, 'not found');
      expect(
        exception.toString(),
        'NotFoundException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );
    });
  });
}
