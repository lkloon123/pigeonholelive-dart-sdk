import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';
import 'package:test/test.dart';

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
  });
}
