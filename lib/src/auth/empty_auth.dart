import 'package:dio/src/options.dart';
import 'package:pigeonholelive_sdk/src/auth/auth_interface.dart';

class EmptyAuth implements AuthInterface {
  @override
  AuthType authType() {
    return AuthType.empty;
  }

  @override
  RequestOptions buildAuth(RequestOptions options) {
    return options;
  }

  @override
  Map<String, String> buildMap() {
    return <String, String>{};
  }
}
