import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Subscription Module', () {
    late var dioAdapter;

    setUpAll(() {
      dioAdapter = DioAdapter();
    });

    group('list', () {
      test('list with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/subscriptions',
          TestingUtils.mockResponse(200, 'subscription/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var subscriptions = await pigeonholeLive.subscription.list();
        expect(
          subscriptions.data?.first.name,
          equalsIgnoringCase('Subscription name'),
        );
      });

      test('list with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/subscriptions',
          TestingUtils.mockResponse(200, 'subscription/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var subscriptions = await pigeonholeLive.subscription.list(
          workspaceId: 1,
        );
        expect(
          subscriptions.data?.first.name,
          equalsIgnoringCase('Subscription name'),
        );
      });

      test('list with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/subscriptions',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.subscription.list(workspaceId: 1);
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
          '/subscriptions',
          TestingUtils.mockResponse(200, 'subscription/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var subscriptions = await pigeonholeLive.subscription.list();

        dioAdapter.onGet(
          '/subscriptions',
          TestingUtils.mockResponse(200, 'subscription/list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        subscriptions = await subscriptions.nextPage();
        expect(
          subscriptions.data?.first.name,
          equalsIgnoringCase('Subscription name 2'),
        );

        expect(
          () => subscriptions.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });

    group('inspect', () {
      test('inspect with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/subscriptions/1',
          TestingUtils.mockResponse(200, 'subscription/subscription.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var subscription = await pigeonholeLive.subscription.inspect(
          subscriptionId: 1,
        );
        expect(subscription.name, equalsIgnoringCase('Subscription name'));
      });

      test('inspect with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/subscriptions/1',
          TestingUtils.mockResponse(200, 'subscription/subscription.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var subscription = await pigeonholeLive.subscription.inspect(
          subscriptionId: 1,
          workspaceId: 1,
        );
        expect(subscription.name, equalsIgnoringCase('Subscription name'));
      });

      test('inspect not found', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/subscriptions/1',
          TestingUtils.mockErrorResponse(404, 'error/notfound.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.subscription.inspect(
              subscriptionId: 1
            );
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
