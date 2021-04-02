import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';

class TestingUtils {
  static Map<String, dynamic> readFixtureFile(String? filename) {
    if (filename == null) {
      return <String, dynamic>{};
    }

    return jsonDecode(
      File('${Directory.current.absolute.path}/test/fixtures/$filename')
          .readAsStringSync(),
    );
  }

  static PigeonholeLive pigeonholeLive(AuthInterface auth, DioAdapter adapter) {
    return PigeonholeLive(
      auth: auth,
      serviceProviders: [
        ServiceProviderWrapper(setupFunc: (getIt) {
          getIt.registerSingleton<HttpClientAdapter>(
            adapter,
            instanceName: 'customHttpClientAdapter',
          );
        })
      ],
    );
  }

  static dynamic mockResponse(int statusCode, String? filename) {
    return (request) {
      request.reply(200, readFixtureFile(filename));
    };
  }

  static Map<String, dynamic> getTestHeaders(AuthInterface token) {
    return {
      Headers.contentTypeHeader: Headers.jsonContentType,
      Headers.contentLengthHeader: Matchers.integer,
    }..addAll(token.buildMap());
  }

  static dynamic mockErrorResponse(int statusCode, String? filename) {
    return (request) {
      request.throws(
        statusCode,
        DioError(
          response: Response(
              statusCode: statusCode,
              requestOptions: RequestOptions(path: 'xxx'),
              data: readFixtureFile(filename)),
          requestOptions: RequestOptions(path: 'xxx'),
          type: DioErrorType.response,
        ),
      );
    };
  }
}
