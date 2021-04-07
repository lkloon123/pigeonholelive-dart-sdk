import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';
import 'package:test/test.dart';
import 'testing_utils.dart';

void main() {
  group('test PigeonholeLive', () {
    test('able to construct PigeonholeLive object with workspacetoken', () {
      try {
        PigeonholeLive(auth: WorkspaceToken(token: 'xxx'));
      } on Exception catch (e) {
        fail(e.toString());
      }
    });

    test('able to construct PigeonholeLive object with oauth', () {
      try {
        PigeonholeLive(auth: OAuthAccessToken(token: 'xxx'));
      } on Exception catch (e) {
        fail(e.toString());
      }
    });

    test('able to update auth after PigeonholeLive constructed', () {
      var pigeonholeLive = PigeonholeLive(auth: OAuthAccessToken(token: 'xxx'));
      expect(
        ServiceProviderManager.instance.getIt.get<AuthInterface>(),
        isA<OAuthAccessToken>(),
      );

      pigeonholeLive.updateAuth(auth: WorkspaceToken(token: 'aaa'));
      expect(
        ServiceProviderManager.instance.getIt.get<AuthInterface>(),
        isA<WorkspaceToken>(),
      );
    });

    test('able to run custom service provider', () async {
      String? testingOnly;
      var dioAdapter = DioAdapter();
      var token = WorkspaceToken(token: 'xxx');

      var pigeonholeLive = PigeonholeLive(
        auth: token,
        serviceProviders: [
          ServiceProviderWrapper(setupFunc: (getIt) {
            getIt.registerSingleton<List<Interceptor>>(
              [
                InterceptorsWrapper(onRequest: (options, handler) {
                  testingOnly = 'testing only';
                  return handler.next(options);
                }),
              ],
              instanceName: 'additionalInterceptors',
            );
          }),
          ServiceProviderWrapper(setupFunc: (getIt) {
            getIt.registerSingleton<HttpClientAdapter>(
              dioAdapter,
              instanceName: 'customHttpClientAdapter',
            );
          }),
        ],
      );

      dioAdapter.onGet(
        '/pigeonholes',
        TestingUtils.mockResponse(200, 'pigeonhole/list.json'),
        headers: TestingUtils.getTestHeaders(token),
      );

      expect(testingOnly, isNull);

      try {
        await pigeonholeLive.pigeonhole.list();

        expect(testingOnly, equals('testing only'));
      } catch (e) {
        fail(e.toString());
      }
    });
  });
}
