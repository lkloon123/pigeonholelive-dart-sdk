import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('pigeonhole exception test', () {
    test('should show correct msg', () {
      var pigeonholeError = PigeonholeError(message: '');
      var exception = PigeonholeException(
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, '');
      expect(
        exception.toString(),
        'PigeonholeException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );

      pigeonholeError = PigeonholeError(message: 'pigeonhole error msg');
      exception = PigeonholeException(
        msg: 'pigeonhole exception msg',
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, 'pigeonhole exception msg');
      expect(
        exception.toString(),
        'PigeonholeException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );
    });
  });
}
