import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Custom Branding Module', () {
    late var dioAdapter;

    setUpAll(() {
      dioAdapter = DioAdapter();
    });

    group('list', () {
      test('list with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/custom-brandings',
          TestingUtils.mockResponse(200, 'custom_brandings/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var customBrandings = await pigeonholeLive.customBranding.list();
        expect(
          customBrandings.data?.first.name,
          equalsIgnoringCase('ACME seasonal theme'),
        );
      });

      test('list with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/custom-brandings',
          TestingUtils.mockResponse(200, 'custom_brandings/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var customBrandings = await pigeonholeLive.customBranding.list(
          workspaceId: 1,
        );
        expect(
          customBrandings.data?.first.name,
          equalsIgnoringCase('ACME seasonal theme'),
        );
      });

      test('list with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/custom-brandings',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.customBranding.list(workspaceId: 1);
          },
          throwsA(isA<UnauthorizedException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('unauthorized'),
          )),
        );
      });

      test('call list result with next page', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/custom-brandings',
          TestingUtils.mockResponse(200, 'custom_brandings/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var customBrandings = await pigeonholeLive.customBranding.list();

        dioAdapter.onGet(
          '/custom-brandings',
          TestingUtils.mockResponse(200, 'custom_brandings/list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        customBrandings = await customBrandings.nextPage();
        expect(
          customBrandings.data?.first.name,
          equalsIgnoringCase('winter theme'),
        );

        expect(
          () => customBrandings.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });
  });
}
