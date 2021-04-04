import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Pigeonhole Module', () {
    var dioAdapter = DioAdapter();

    setUpAll(() {
      dioAdapter = DioAdapter();
    });

    group('list', () {
      test('list with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes',
          TestingUtils.mockResponse(200, 'pigeonhole/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonholes = await pigeonholeLive.pigeonhole.list();
        expect(pigeonholes.data?.first.passcode, equalsIgnoringCase('KQWBC9'));
      });

      test('list with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes',
          TestingUtils.mockResponse(200, 'pigeonhole/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonholes = await pigeonholeLive.pigeonhole.list(workspaceId: 1);
        expect(pigeonholes.data?.first.passcode, equalsIgnoringCase('KQWBC9'));
      });

      test('list with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.pigeonhole.list(workspaceId: 1);
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
          '/pigeonholes',
          TestingUtils.mockResponse(200, 'pigeonhole/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonholes = await pigeonholeLive.pigeonhole.list();

        dioAdapter.onGet(
          '/pigeonholes',
          TestingUtils.mockResponse(200, 'pigeonhole/list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        pigeonholes = await pigeonholes.nextPage();
        expect(pigeonholes.data?.first.passcode, equalsIgnoringCase('ASDFGH'));

        expect(
          () => pigeonholes.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });

      test('list with filter', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);
        var filter = PigeonholeFilter(id: [1]);

        dioAdapter.onGet(
          '/pigeonholes',
          TestingUtils.mockResponse(200, 'pigeonhole/list.json'),
          queryParameters: filter.build(),
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonholes = await pigeonholeLive.pigeonhole.list(
          filter: filter,
        );
        expect(pigeonholes.data?.first.passcode, equalsIgnoringCase('KQWBC9'));

        pigeonholes = await pigeonholeLive.pigeonhole.list(
          filter: filter.build(),
        );
        expect(pigeonholes.data?.first.passcode, equalsIgnoringCase('KQWBC9'));
      });
    });

    group('create', () {
      test('create with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes',
          TestingUtils.mockResponse(201, 'pigeonhole/pigeonhole.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonhole = await pigeonholeLive.pigeonhole.create(
          pigeonhole: Pigeonhole.fromJson(
            TestingUtils.readFixtureFile('pigeonhole/pigeonhole.json'),
          ),
        );
        expect(pigeonhole.passcode, equalsIgnoringCase('KQWBC9'));
      });

      test('create with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes',
          TestingUtils.mockResponse(201, 'pigeonhole/pigeonhole.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonhole = await pigeonholeLive.pigeonhole.create(
          pigeonhole: Pigeonhole.fromJson(
            TestingUtils.readFixtureFile('pigeonhole/pigeonhole.json'),
          ),
          workspaceId: 1,
        );
        expect(pigeonhole.passcode, equalsIgnoringCase('KQWBC9'));
      });

      test('create with validation error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes',
          TestingUtils.mockErrorResponse(422, 'error/validation.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.pigeonhole.create(
              pigeonhole: Pigeonhole.fromJson(
                TestingUtils.readFixtureFile('pigeonhole/pigeonhole.json'),
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
          '/pigeonholes/31',
          TestingUtils.mockResponse(200, 'pigeonhole/pigeonhole.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonhole = await pigeonholeLive.pigeonhole.inspect(
          pigeonholeId: 31,
        );
        expect(pigeonhole.passcode, equalsIgnoringCase('KQWBC9'));
      });

      test('inspect with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/31',
          TestingUtils.mockResponse(200, 'pigeonhole/pigeonhole.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonhole = await pigeonholeLive.pigeonhole
            .inspect(pigeonholeId: 31, workspaceId: 1);
        expect(pigeonhole.passcode, equalsIgnoringCase('KQWBC9'));
      });

      test('inspect not found', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/32',
          TestingUtils.mockErrorResponse(404, 'error/notfound.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.pigeonhole.inspect(pigeonholeId: 32);
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
          '/pigeonholes/31/update',
          TestingUtils.mockResponse(200, 'pigeonhole/pigeonhole.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonhole = await pigeonholeLive.pigeonhole.update(
          pigeonhole: Pigeonhole.fromJson(
            TestingUtils.readFixtureFile('pigeonhole/pigeonhole.json'),
          ),
        );
        expect(pigeonhole.passcode, equalsIgnoringCase('KQWBC9'));
      });

      test('update with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/31/update',
          TestingUtils.mockResponse(200, 'pigeonhole/pigeonhole.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var pigeonhole = await pigeonholeLive.pigeonhole.update(
          pigeonhole: Pigeonhole.fromJson(
            TestingUtils.readFixtureFile('pigeonhole/pigeonhole.json'),
          ),
          workspaceId: 1,
        );
        expect(pigeonhole.passcode, equalsIgnoringCase('KQWBC9'));
      });

      test('update with validation error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/31/update',
          TestingUtils.mockErrorResponse(422, 'error/validation.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.pigeonhole.update(
              pigeonhole: Pigeonhole(id: 31),
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
