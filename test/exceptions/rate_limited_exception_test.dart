import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('rate limited exception test', () {
    test('should show correct msg', () {
      var pigeonholeError = PigeonholeError(message: '');
      var exception = RateLimitedException(
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, '');
      expect(
        exception.toString(),
        'RateLimitedException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );

      pigeonholeError = PigeonholeError(message: 'rate limited error');
      exception = RateLimitedException(
        msg: 'rate limited msg',
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, 'rate limited msg');
      expect(
        exception.toString(),
        'RateLimitedException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );
    });
  });
}
