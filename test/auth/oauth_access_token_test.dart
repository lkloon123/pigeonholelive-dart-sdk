import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('OAuth access token test', () {
    test('should build correct auth type', () {
      var oauthAccessToken = OAuthAccessToken(token: 'xxx');

      expect(oauthAccessToken.authType(), AuthType.oAuth);
    });

    test('should build correct RequestOption', () {
      var oauthAccessToken = OAuthAccessToken(token: 'xxx');
      var requestOption = RequestOptions(path: 'test');

      expect(
        oauthAccessToken.buildAuth(requestOption).headers,
        {
          Headers.contentTypeHeader: Headers.jsonContentType,
          'authorization': 'Bearer xxx',
        },
      );
    });

    test('should build correct Map', () {
      var oauthAccessToken = OAuthAccessToken(token: 'xxx');

      expect(oauthAccessToken.buildMap().length, 1);
      expect(oauthAccessToken.buildMap().containsKey('authorization'), true);
      expect(oauthAccessToken.buildMap()['authorization'], 'Bearer xxx');
    });
  });
}
