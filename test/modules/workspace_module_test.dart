import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Workspace Module', () {
    late var dioAdapter;

    setUpAll(() {
      dioAdapter = DioAdapter();
    });

    group('list', () {
      test('list with workspace token throws exception', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces',
          TestingUtils.mockResponse(200, 'workspace/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.workspace.list();
          },
          throwsA(isA<Exception>().having(
            (error) => error.toString(),
            'error message',
            equalsIgnoringCase(
              'Exception: Workspace token is not supported for this method.',
            ),
          )),
        );
      });

      test('list with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces',
          TestingUtils.mockResponse(200, 'workspace/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var workspaces = await pigeonholeLive.workspace.list();
        expect(workspaces.data?.first.name, equalsIgnoringCase('Example name'));
      });

      test('list with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.workspace.list();
          },
          throwsA(isA<UnauthorizedException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('unauthorized'),
          )),
        );
      });

      test('call list result with next page', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces',
          TestingUtils.mockResponse(200, 'workspace/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var workspaces = await pigeonholeLive.workspace.list();

        dioAdapter.onGet(
          '/workspaces',
          TestingUtils.mockResponse(200, 'workspace/list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        workspaces = await workspaces.nextPage();
        expect(
          workspaces.data?.first.name,
          equalsIgnoringCase('Another Example name'),
        );

        expect(
          () => workspaces.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });

    group('inspect', () {
      test('inspect with workspace token throws exception', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1',
          TestingUtils.mockResponse(200, 'workspace/workspace.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.workspace.inspect(workspaceId: 1);
          },
          throwsA(isA<Exception>().having(
            (error) => error.toString(),
            'error message',
            equalsIgnoringCase(
              'Exception: Workspace token is not supported for this method.',
            ),
          )),
        );
      });

      test('inspect with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1',
          TestingUtils.mockResponse(200, 'workspace/workspace.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var workspace = await pigeonholeLive.workspace.inspect(workspaceId: 1);
        expect(workspace.name, equalsIgnoringCase('Example name'));
      });

      test('inspect not found', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1',
          TestingUtils.mockErrorResponse(404, 'error/notfound.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.workspace.inspect(workspaceId: 1);
          },
          throwsA(isA<NotFoundException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('not found'),
          )),
        );
      });
    });
  });
}
