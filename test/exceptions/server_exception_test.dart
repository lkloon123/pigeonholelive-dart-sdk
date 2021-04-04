import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('server exception test', () {
    test('should show correct msg', () {
      var pigeonholeError = PigeonholeError(message: '');
      var exception = ServerException(
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, '');
      expect(
        exception.toString(),
        'ServerException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );

      pigeonholeError = PigeonholeError(message: 'server error');
      exception = ServerException(
        msg: 'server msg',
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, 'server msg');
      expect(
        exception.toString(),
        'ServerException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );
    });
  });
}
