import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:pigeonholelive_sdk/src/models/enums/speaker_role.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/forms/one_time_link_form.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/forms/speaker_form.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Session Module', () {
    late var dioAdapter;

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
          liveSessionId: 1,
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
            .inspect(pigeonholeId: 1, liveSessionId: 1, workspaceId: 1);
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
            await pigeonholeLive.session.inspect(
              pigeonholeId: 1,
              liveSessionId: 5,
            );
          },
          throwsA(isA<NotFoundException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('not found'),
          )),
        );
      });

      test('should return chat live session', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1',
          TestingUtils.mockResponse(200, 'session/chat.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session.inspect(
          pigeonholeId: 1,
          liveSessionId: 1,
        );

        expect(session, isA<Chat>());
        expect(session.name, equalsIgnoringCase('Chat session'));
      });

      test('should return Poll Multiple Choice live session', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1',
          TestingUtils.mockResponse(200, 'session/poll_multiple_choice.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session.inspect(
          pigeonholeId: 1,
          liveSessionId: 1,
        );

        expect(session, isA<PollMultipleChoice>());
        expect(
          session.name,
          equalsIgnoringCase('Poll Multiple Choice session'),
        );
      });

      test('should return live session for break', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1',
          TestingUtils.mockResponse(200, 'session/break.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var session = await pigeonholeLive.session.inspect(
          pigeonholeId: 1,
          liveSessionId: 1,
        );

        expect(session, isA<LiveSession>());
        expect(
          session.name,
          equalsIgnoringCase('Break session'),
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

    group('list nested session', () {
      test('list nested session with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockResponse(200, 'session/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var sessions = await pigeonholeLive.session.listNestedSession(
          pigeonholeId: 1,
          liveSessionId: 1,
        );
        expect(sessions.data?.first.name, equalsIgnoringCase('Session name'));
      });

      test('list nested session with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockResponse(200, 'session/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var sessions = await pigeonholeLive.session.listNestedSession(
          pigeonholeId: 1,
          workspaceId: 1,
          liveSessionId: 1,
        );
        expect(sessions.data?.first.name, equalsIgnoringCase('Session name'));
      });

      test('list nested session with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.listNestedSession(
              pigeonholeId: 1,
              workspaceId: 1,
              liveSessionId: 1,
            );
          },
          throwsA(isA<UnauthorizedException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('unauthorized'),
          )),
        );
      });

      test('call list nested session result with next page', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockResponse(200, 'session/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var sessions = await pigeonholeLive.session.listNestedSession(
          pigeonholeId: 1,
          liveSessionId: 1,
        );

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/relationships/sessions',
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

    group('nest session', () {
      test('nest session with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1},
              {'id': 2},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.nestSession(
            pigeonholeId: 1,
            liveSessionId: 1,
            liveSessionIdsForNest: [1, 2],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('nest session with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1},
              {'id': 2},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.nestSession(
            pigeonholeId: 1,
            liveSessionId: 1,
            workspaceId: 1,
            liveSessionIdsForNest: [1, 2],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('nest session with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          data: {
            'data': [
              {'id': 1},
              {'id': 2},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.nestSession(
              pigeonholeId: 1,
              liveSessionId: 1,
              liveSessionIdsForNest: [1, 2],
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

    group('replace nest session', () {
      test('replace nest session with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPatch(
          '/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1},
              {'id': 2},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.replaceNestedSession(
            pigeonholeId: 1,
            liveSessionId: 1,
            liveSessionIdsForNest: [1, 2],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('replace nest session with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPatch(
          '/workspaces/1/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1},
              {'id': 2},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.replaceNestedSession(
            pigeonholeId: 1,
            liveSessionId: 1,
            workspaceId: 1,
            liveSessionIdsForNest: [1, 2],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('replace nest session with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPatch(
          '/pigeonholes/1/sessions/1/relationships/sessions',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          data: {
            'data': [
              {'id': 1},
              {'id': 2},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.replaceNestedSession(
              pigeonholeId: 1,
              liveSessionId: 1,
              liveSessionIdsForNest: [1, 2],
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

    group('list speakers in session', () {
      test('list speakers in session with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockResponse(200, 'speaker/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var speakers = await pigeonholeLive.session.listSpeakers(
          pigeonholeId: 1,
          liveSessionId: 1,
        );
        expect(
          speakers.data?.first.fullName,
          equalsIgnoringCase('Jessica Loo'),
        );
      });

      test('list speakers in session with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockResponse(200, 'speaker/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var speakers = await pigeonholeLive.session.listSpeakers(
          pigeonholeId: 1,
          workspaceId: 1,
          liveSessionId: 1,
        );
        expect(
          speakers.data?.first.fullName,
          equalsIgnoringCase('Jessica Loo'),
        );
      });

      test('list speakers in session with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.listSpeakers(
              pigeonholeId: 1,
              workspaceId: 1,
              liveSessionId: 1,
            );
          },
          throwsA(isA<UnauthorizedException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('unauthorized'),
          )),
        );
      });

      test('call list speakers in session result with next page', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockResponse(200, 'speaker/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var speakers = await pigeonholeLive.session.listSpeakers(
          pigeonholeId: 1,
          liveSessionId: 1,
        );

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockResponse(200, 'speaker/list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        speakers = await speakers.nextPage();
        expect(speakers.data?.first.fullName, equalsIgnoringCase('David'));

        expect(
          () => speakers.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });

    group('add speaker', () {
      test('add speaker with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1, 'role': 'speaker'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.addSpeaker(
            pigeonholeId: 1,
            liveSessionId: 1,
            speakers: [SpeakerForm(id: 1, role: SpeakerRole.speaker)],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('add speaker with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1, 'role': 'speaker'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.addSpeaker(
            pigeonholeId: 1,
            liveSessionId: 1,
            workspaceId: 1,
            speakers: [SpeakerForm(id: 1, role: SpeakerRole.speaker)],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('add speaker with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          data: {
            'data': [
              {'id': 1, 'role': 'speaker'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.addSpeaker(
              pigeonholeId: 1,
              liveSessionId: 1,
              speakers: [SpeakerForm(id: 1, role: SpeakerRole.speaker)],
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

    group('replace speaker', () {
      test('replace speaker with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPatch(
          '/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1, 'role': 'speaker'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.replaceSpeaker(
            pigeonholeId: 1,
            liveSessionId: 1,
            speakers: [SpeakerForm(id: 1, role: SpeakerRole.speaker)],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('replace speaker with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPatch(
          '/workspaces/1/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1, 'role': 'speaker'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.replaceSpeaker(
            pigeonholeId: 1,
            liveSessionId: 1,
            workspaceId: 1,
            speakers: [SpeakerForm(id: 1, role: SpeakerRole.speaker)],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('replace speaker with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPatch(
          '/pigeonholes/1/sessions/1/relationships/speakers',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          data: {
            'data': [
              {'id': 1, 'role': 'speaker'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.replaceSpeaker(
              pigeonholeId: 1,
              liveSessionId: 1,
              speakers: [SpeakerForm(id: 1, role: SpeakerRole.speaker)],
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

    group('generate one time link', () {
      test('generate one time link with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/one-time-links/generate',
          TestingUtils.mockResponse(200, 'session/one_time_link.json'),
          data: {
            'for': 'admin-panel',
            'ttl': 3600,
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          var oneTimeLink = await pigeonholeLive.session.generateOneTimeLink(
            pigeonholeId: 1,
            liveSessionId: 1,
            oneTimeLinkForm: OneTimeLinkForm(
              oneTimeLinkFor: 'admin-panel',
              ttl: 3600,
            ),
          );

          expect(oneTimeLink.oneTimeLinkFor, equalsIgnoringCase('admin-panel'));
        } catch (e) {
          fail(e.toString());
        }
      });

      test('generate one time link with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/sessions/1/one-time-links/generate',
          TestingUtils.mockResponse(200, 'session/one_time_link.json'),
          data: {
            'for': 'admin-panel',
            'ttl': 3600,
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          var oneTimeLink = await pigeonholeLive.session.generateOneTimeLink(
            pigeonholeId: 1,
            liveSessionId: 1,
            workspaceId: 1,
            oneTimeLinkForm: OneTimeLinkForm(
              oneTimeLinkFor: 'admin-panel',
              ttl: 3600,
            ),
          );

          expect(oneTimeLink.oneTimeLinkFor, equalsIgnoringCase('admin-panel'));
        } catch (e) {
          fail(e.toString());
        }
      });

      test('generate one time link with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/sessions/1/one-time-links/generate',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          data: {
            'for': 'admin-panel',
            'ttl': 3600,
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.generateOneTimeLink(
              pigeonholeId: 1,
              liveSessionId: 1,
              oneTimeLinkForm: OneTimeLinkForm(
                oneTimeLinkFor: 'admin-panel',
                ttl: 3600,
              ),
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

    group('delete one time link', () {
      test('delete one time link with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/pigeonholes/1/sessions/1/one-time-links/xxx',
          TestingUtils.mockResponse(204, null),
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.deleteOneTimeLink(
            pigeonholeId: 1,
            liveSessionId: 1,
            token: 'xxx',
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('delete one time link with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/workspaces/1/pigeonholes/1/sessions/1/one-time-links/xxx',
          TestingUtils.mockResponse(204, null),
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.session.deleteOneTimeLink(
              pigeonholeId: 1, liveSessionId: 1, workspaceId: 1, token: 'xxx');
        } catch (e) {
          fail(e.toString());
        }
      });

      test('delete one time link with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/pigeonholes/1/sessions/1/one-time-links/xxx',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.deleteOneTimeLink(
              pigeonholeId: 1,
              liveSessionId: 1,
              token: 'xxx',
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

    group('list one time link', () {
      test('list one time link with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/one-time-links',
          TestingUtils.mockResponse(200, 'session/one_time_link_list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var oneTimeLinks = await pigeonholeLive.session.listOneTimeLinks(
          pigeonholeId: 1,
          liveSessionId: 1,
        );
        expect(
          oneTimeLinks.data?.first.oneTimeLinkFor,
          equalsIgnoringCase('admin-panel'),
        );
      });

      test('list one time link with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1/one-time-links',
          TestingUtils.mockResponse(200, 'session/one_time_link_list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var oneTimeLinks = await pigeonholeLive.session.listOneTimeLinks(
          pigeonholeId: 1,
          workspaceId: 1,
          liveSessionId: 1,
        );
        expect(
          oneTimeLinks.data?.first.oneTimeLinkFor,
          equalsIgnoringCase('admin-panel'),
        );
      });

      test('list one time link with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1/one-time-links',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.listOneTimeLinks(
              pigeonholeId: 1,
              workspaceId: 1,
              liveSessionId: 1,
            );
          },
          throwsA(isA<UnauthorizedException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('unauthorized'),
          )),
        );
      });

      test('call list one time link result with next page', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/one-time-links',
          TestingUtils.mockResponse(200, 'session/one_time_link_list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var oneTimeLinks = await pigeonholeLive.session.listOneTimeLinks(
          pigeonholeId: 1,
          liveSessionId: 1,
        );

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/one-time-links',
          TestingUtils.mockResponse(200, 'session/one_time_link_list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        oneTimeLinks = await oneTimeLinks.nextPage();
        expect(
          oneTimeLinks.data?.first.oneTimeLinkFor,
          equalsIgnoringCase('projector-panel'),
        );

        expect(
          () => oneTimeLinks.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });

    group('insights', () {
      test('insights with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/insights',
          TestingUtils.mockResponse(200, 'session/insights.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var insights = await pigeonholeLive.session.insights(
          pigeonholeId: 1,
          liveSessionId: 1,
        );
        expect(
          insights.data?.first.content,
          equalsIgnoringCase('Does four plus four equal eight?'),
        );
      });

      test('insights with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1/insights',
          TestingUtils.mockResponse(200, 'session/insights.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var insights = await pigeonholeLive.session.insights(
          pigeonholeId: 1,
          workspaceId: 1,
          liveSessionId: 1,
        );
        expect(
          insights.data?.first.content,
          equalsIgnoringCase('Does four plus four equal eight?'),
        );
      });

      test('insights with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/sessions/1/insights',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.session.insights(
              pigeonholeId: 1,
              workspaceId: 1,
              liveSessionId: 1,
            );
          },
          throwsA(isA<UnauthorizedException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('unauthorized'),
          )),
        );
      });

      test('call insights result with next page', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/insights',
          TestingUtils.mockResponse(200, 'session/insights.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var insights = await pigeonholeLive.session.insights(
          pigeonholeId: 1,
          liveSessionId: 1,
        );

        dioAdapter.onGet(
          '/pigeonholes/1/sessions/1/insights',
          TestingUtils.mockResponse(200, 'session/insights2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        var insights2 = await insights.nextPage();
        expect(
          insights2.data?.first.content,
          equalsIgnoringCase('question 2?'),
        );

        expect(
          () => insights2.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });
  });
}
