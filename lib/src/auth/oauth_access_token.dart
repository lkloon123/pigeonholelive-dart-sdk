import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/src/auth/auth_interface.dart';

class OAuthAccessToken implements AuthInterface {
  String token;

  OAuthAccessToken({required this.token});

  @override
  AuthType authType() {
    return AuthType.oAuth;
  }

  @override
  RequestOptions buildAuth(RequestOptions options) {
    return options..headers['authorization'] = 'Bearer $token';
  }

  @override
  Map<String, String> buildMap() {
    return {'authorization': 'Bearer $token'};
  }
}
