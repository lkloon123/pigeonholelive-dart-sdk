import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Session Module', () {
    var dioAdapter = DioAdapter();

    setUpAll(() {
      dioAdapter = DioAdapter();
    });

    group('list', () {
      test('list with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions',
          TestingUtils.mockResponse(200, 'session/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var sessions = await pigeonholeLive.session.list(pigeonholeId: 1);
        expect(sessions.data?.first.name, equalsIgnoringCase('Session name'));
      });

      test('list with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions',
          TestingUtils.mockResponse(200, 'session/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var sessions = await pigeonholeLive.session.list(
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(sessions.data?.first.name, equalsIgnoringCase('Session name'));
      });

      test('list with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.list(pigeonholeId: 1, workspaceId: 1);
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
          '/pigeonholes/1/sessions',
          TestingUtils.mockResponse(200, 'session/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var sessions = await pigeonholeLive.session.list(pigeonholeId: 1);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions',
          TestingUtils.mockResponse(200, 'session/list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        sessions = await sessions.nextPage();
        expect(
          sessions.data?.first.name,
          equalsIgnoringCase('Another Session name'),
        );

        expect(
          () => sessions.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });

    group('create', () {
      test('create with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions',
          TestingUtils.mockResponse(201, 'session/session.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session.create(
          pigeonholeId: 1,
          liveSession: LiveSession.fromJson(
            TestingUtils.readFixtureFile('session/session.json'),
          ),
        );
        expect(session.name, equalsIgnoringCase('Session name'));
      });

      test('create with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/sessions',
          TestingUtils.mockResponse(201, 'session/session.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session.create(
          pigeonholeId: 1,
          liveSession: LiveSession.fromJson(
            TestingUtils.readFixtureFile('session/session.json'),
          ),
          workspaceId: 1,
        );
        expect(session.name, equalsIgnoringCase('Session name'));
      });

      test('create with validation error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions',
          TestingUtils.mockErrorResponse(422, 'error/validation.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.create(
              pigeonholeId: 1,
              liveSession: LiveSession.fromJson(
                TestingUtils.readFixtureFile('session/session.json'),
              ),
            );
          },
          throwsA(isA<ValidationException>().having(
            (error) => error.validationErrors.errors?.first.message,
            'error message',
            equalsIgnoringCase('The field is required.'),
          )),
        );
      });
    });

    group('inspect', () {
      test('inspect with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1',
          TestingUtils.mockResponse(200, 'session/session.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session.inspect(
          pigeonholeId: 1,
          sessionId: 1,
        );
        expect(session.name, equalsIgnoringCase('Session name'));
      });

      test('inspect with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1',
          TestingUtils.mockResponse(200, 'session/session.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session
            .inspect(pigeonholeId: 1, sessionId: 1, workspaceId: 1);
        expect(session.name, equalsIgnoringCase('Session name'));
      });

      test('inspect not found', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/5',
          TestingUtils.mockErrorResponse(404, 'error/notfound.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.inspect(pigeonholeId: 1, sessionId: 5);
          },
          throwsA(isA<NotFoundException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('not found'),
          )),
        );
      });
    });

    group('update', () {
      test('update with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/update',
          TestingUtils.mockResponse(200, 'session/session.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session.update(
          pigeonholeId: 1,
          liveSession: LiveSession.fromJson(
            TestingUtils.readFixtureFile('session/session.json'),
          ),
        );
        expect(session.name, equalsIgnoringCase('Session name'));
      });

      test('update with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/sessions/1/update',
          TestingUtils.mockResponse(200, 'session/session.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session.update(
          pigeonholeId: 1,
          liveSession: LiveSession.fromJson(
            TestingUtils.readFixtureFile('session/session.json'),
          ),
          workspaceId: 1,
        );
        expect(session.name, equalsIgnoringCase('Session name'));
      });

      test('update with validation error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/5/update',
          TestingUtils.mockErrorResponse(422, 'error/validation.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.update(
              pigeonholeId: 1,
              liveSession: LiveSession(id: 5),
            );
          },
          throwsA(isA<ValidationException>().having(
            (error) => error.validationErrors.errors?.first.message,
            'error message',
            equalsIgnoringCase('The field is required.'),
          )),
        );
      });
    });

    group('start a session', () {
      test('start a session with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/start',
          TestingUtils.mockResponse(204, null),
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.startASession(
            pigeonholeId: 1,
            liveSessionId: 1,
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('start a session with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/sessions/1/start',
          TestingUtils.mockResponse(204, null),
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.startASession(
            pigeonholeId: 1,
            liveSessionId: 1,
            workspaceId: 1,
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('start a session with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/start',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.startASession(
              pigeonholeId: 1,
              liveSessionId: 1,
            );
          },
          throwsA(isA<ServerException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('This is an error description'),
          )),
        );
      });
    });
  });
}
