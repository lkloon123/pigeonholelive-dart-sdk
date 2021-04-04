import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('unauthorized exception test', () {
    test('should show correct msg', () {
      var pigeonholeError = PigeonholeError(message: '');
      var exception = UnauthorizedException(
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, '');
      expect(
        exception.toString(),
        'UnauthorizedException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );

      pigeonholeError = PigeonholeError(message: 'unauthorized error');
      exception = UnauthorizedException(
        msg: 'unauthorized msg',
        pigeonholeError: pigeonholeError,
        requestOptions: RequestOptions(path: 'test'),
      );

      expect(exception.message, 'unauthorized msg');
      expect(
        exception.toString(),
        'UnauthorizedException: PigeonholeError ${jsonEncode(pigeonholeError.toJson())}',
      );
    });
  });
}
