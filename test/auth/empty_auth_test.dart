import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Empty auth test', () {
    test('should build correct auth type', () {
      var emptyAuth = EmptyAuth();

      expect(emptyAuth.authType(), AuthType.empty);
    });

    test('should build correct RequestOption', () {
      var emptyAuth = EmptyAuth();
      var requestOption = RequestOptions(path: 'test');

      expect(
        emptyAuth.buildAuth(requestOption).headers,
        {Headers.contentTypeHeader: Headers.jsonContentType},
      );
    });

    test('should build correct Map', () {
      var emptyAuth = EmptyAuth();

      expect(emptyAuth.buildMap().length, 0);
    });
  });
}
