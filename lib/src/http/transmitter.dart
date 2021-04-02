import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';

class Transmitter {
  Dio get _http => ServiceProviderManager.instance.getIt.get<Dio>();

  Future<Response> send({
    required HttpMethod method,
    required String uri,
    Map<String, dynamic>? params,
  }) {
    switch (method) {
      case HttpMethod.get:
        return _http.get('/$uri', queryParameters: params);
      case HttpMethod.post:
        return _http.post('/$uri', data: params);
      case HttpMethod.patch:
        return _http.patch('/$uri', data: params);
      case HttpMethod.delete:
        return _http.delete('/$uri', data: params);
    }
  }
}
