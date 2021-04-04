import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Workspace token test', () {
    test('should build correct auth type', () {
      var workspaceToken = WorkspaceToken(token: 'xxx');

      expect(workspaceToken.authType(), AuthType.token);
    });

    test('should build correct RequestOption', () {
      var workspaceToken = WorkspaceToken(token: 'xxx');
      var requestOption = RequestOptions(path: 'test');

      expect(
        workspaceToken.buildAuth(requestOption).headers,
        {
          Headers.contentTypeHeader: Headers.jsonContentType,
          'x-api-key': 'xxx',
        },
      );
    });

    test('should build correct Map', () {
      var workspaceToken = WorkspaceToken(token: 'xxx');

      expect(workspaceToken.buildMap().length, 1);
      expect(workspaceToken.buildMap().containsKey('x-api-key'), true);
      expect(workspaceToken.buildMap()['x-api-key'], 'xxx');
    });
  });
}
