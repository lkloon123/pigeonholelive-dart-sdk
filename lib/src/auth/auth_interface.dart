import 'package:dio/dio.dart';

enum AuthType {
  token,
  oAuth,
  empty,
}


abstract class AuthInterface {
  AuthType authType();

  RequestOptions buildAuth(RequestOptions options);

  Map<String, String> buildMap();
}
