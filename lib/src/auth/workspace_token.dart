import 'package:dio/src/options.dart';
import 'package:pigeonholelive_sdk/src/auth/auth_interface.dart';

class WorkspaceToken implements AuthInterface {
  String token;

  WorkspaceToken({required this.token});

  @override
  AuthType authType() {
    return AuthType.token;
  }

  @override
  RequestOptions buildAuth(RequestOptions options) {
    return options..headers['x-api-key'] = token;
  }

  @override
  Map<String, String> buildMap() {
    return {'x-api-key': token};
  }
}
