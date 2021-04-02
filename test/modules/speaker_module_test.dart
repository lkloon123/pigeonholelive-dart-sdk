import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Speaker Module', () {
    var dioAdapter = DioAdapter();

    setUpAll(() {
      dioAdapter = DioAdapter();
    });

    group('list', () {
      test('list with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/speakers',
          TestingUtils.mockResponse(200, 'speaker/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var speakers = await pigeonholeLive.speaker.list(pigeonholeId: 1);
        expect(
            speakers.data?.first.fullName, equalsIgnoringCase('Jessica Loo'));
      });

      test('list with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/speakers',
          TestingUtils.mockResponse(200, 'speaker/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var speakers = await pigeonholeLive.speaker.list(
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(
            speakers.data?.first.fullName, equalsIgnoringCase('Jessica Loo'));
      });

      test('list with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/speakers',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.speaker.list(pigeonholeId: 1, workspaceId: 1);
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
          '/pigeonholes/1/speakers',
          TestingUtils.mockResponse(200, 'speaker/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var speakers = await pigeonholeLive.speaker.list(pigeonholeId: 1);

        dioAdapter.onGet(
          '/pigeonholes/1/speakers',
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

    group('create', () {
      test('create with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/speakers',
          TestingUtils.mockResponse(201, 'speaker/speaker.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var speaker = await pigeonholeLive.speaker.create(
          speaker: Speaker.fromJson(
            TestingUtils.readFixtureFile('speaker/speaker.json'),
          ),
          pigeonholeId: 1,
        );
        expect(speaker.fullName, equalsIgnoringCase('Jessica Loo'));
      });

      test('create with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/speakers',
          TestingUtils.mockResponse(201, 'speaker/speaker.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var speaker = await pigeonholeLive.speaker.create(
          speaker: Speaker.fromJson(
            TestingUtils.readFixtureFile('speaker/speaker.json'),
          ),
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(speaker.fullName, equalsIgnoringCase('Jessica Loo'));
      });

      test('create with validation error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/speakers',
          TestingUtils.mockErrorResponse(422, 'error/validation.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.speaker.create(
              speaker: Speaker.fromJson(
                TestingUtils.readFixtureFile('speaker/speaker.json'),
              ),
              pigeonholeId: 1,
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

    group('update', () {
      test('update with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/speakers/1/update',
          TestingUtils.mockResponse(200, 'speaker/speaker.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var speaker = await pigeonholeLive.speaker.update(
          speaker: Speaker.fromJson(
            TestingUtils.readFixtureFile('speaker/speaker.json'),
          ),
          pigeonholeId: 1,
        );
        expect(speaker.fullName, equalsIgnoringCase('Jessica Loo'));
      });

      test('update with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/speakers/1/update',
          TestingUtils.mockResponse(200, 'speaker/speaker.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var speaker = await pigeonholeLive.speaker.update(
          speaker: Speaker.fromJson(
            TestingUtils.readFixtureFile('speaker/speaker.json'),
          ),
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(speaker.fullName, equalsIgnoringCase('Jessica Loo'));
      });

      test('update with validation error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/speakers/1/update',
          TestingUtils.mockErrorResponse(422, 'error/validation.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.speaker.update(
              speaker: Speaker(id: 1),
              pigeonholeId: 1,
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
  });
}
