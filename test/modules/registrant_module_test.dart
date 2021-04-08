import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:pigeonholelive_sdk/src/auth/oauth_access_token.dart';
import 'package:pigeonholelive_sdk/src/auth/workspace_token.dart';
import 'package:pigeonholelive_sdk/src/models/registrant/forms/registrant_form.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Registrant Module', () {
    late var dioAdapter;

    setUpAll(() {
      dioAdapter = DioAdapter();
    });

    group('list', () {
      test('list with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/registrants',
          TestingUtils.mockResponse(200, 'registrant/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var registrants = await pigeonholeLive.registrant.list(pigeonholeId: 1);
        expect(
          registrants.data?.first.attendeeCode,
          equalsIgnoringCase('ABC12'),
        );
      });

      test('list with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/registrants',
          TestingUtils.mockResponse(200, 'registrant/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var registrants = await pigeonholeLive.registrant.list(
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(
          registrants.data?.first.attendeeCode,
          equalsIgnoringCase('ABC12'),
        );
      });

      test('list with unauthorized error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/registrants',
          TestingUtils.mockErrorResponse(401, 'error/unauthorized.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.registrant.list(
              pigeonholeId: 1,
              workspaceId: 1,
            );
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
          '/pigeonholes/1/registrants',
          TestingUtils.mockResponse(200, 'registrant/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var registrants = await pigeonholeLive.registrant.list(pigeonholeId: 1);

        dioAdapter.onGet(
          '/pigeonholes/1/registrants',
          TestingUtils.mockResponse(200, 'registrant/list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        registrants = await registrants.nextPage();
        expect(
          registrants.data?.first.attendeeCode,
          equalsIgnoringCase('GHJ45'),
        );

        expect(
          () => registrants.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });

    group('create', () {
      test('create with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/registrants',
          TestingUtils.mockResponse(201, 'registrant/registrant.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var registrant = await pigeonholeLive.registrant.create(
          registrant: Registrant.fromJson(
            TestingUtils.readFixtureFile('registrant/registrant.json'),
          ),
          pigeonholeId: 1,
        );
        expect(registrant.attendeeCode, equalsIgnoringCase('ABC12'));
      });

      test('create with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/registrants',
          TestingUtils.mockResponse(201, 'registrant/registrant.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var registrant = await pigeonholeLive.registrant.create(
          registrant: Registrant.fromJson(
            TestingUtils.readFixtureFile('registrant/registrant.json'),
          ),
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(registrant.attendeeCode, equalsIgnoringCase('ABC12'));
      });

      test('create with validation error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/registrants',
          TestingUtils.mockErrorResponse(422, 'error/validation.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.registrant.create(
              registrant: Registrant.fromJson(
                TestingUtils.readFixtureFile('registrant/registrant.json'),
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
          '/pigeonholes/1/registrants/1/update',
          TestingUtils.mockResponse(200, 'registrant/registrant.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var registrant = await pigeonholeLive.registrant.update(
          registrant: Registrant.fromJson(
            TestingUtils.readFixtureFile('registrant/registrant.json'),
          ),
          pigeonholeId: 1,
        );
        expect(registrant.attendeeCode, equalsIgnoringCase('ABC12'));
      });

      test('update with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/registrants/1/update',
          TestingUtils.mockResponse(200, 'registrant/registrant.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var registrant = await pigeonholeLive.registrant.update(
          registrant: Registrant.fromJson(
            TestingUtils.readFixtureFile('registrant/registrant.json'),
          ),
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(registrant.attendeeCode, equalsIgnoringCase('ABC12'));
      });

      test('update with validation error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/registrants/1/update',
          TestingUtils.mockErrorResponse(422, 'error/validation.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.registrant.update(
              registrant: Registrant.fromJson(
                TestingUtils.readFixtureFile('registrant/registrant.json'),
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

    group('delete', () {
      test('delete with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/pigeonholes/1/registrants/1',
          TestingUtils.mockResponse(204, null),
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.registrant.delete(
            pigeonholeId: 1,
            registrantId: 1,
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('delete with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/workspaces/1/pigeonholes/1/registrants/1',
          TestingUtils.mockResponse(204, null),
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.registrant.delete(
            pigeonholeId: 1,
            registrantId: 1,
            workspaceId: 1,
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('delete with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/pigeonholes/1/registrants/1',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.registrant.delete(
              pigeonholeId: 1,
              registrantId: 1,
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

    group('bulk update', () {
      test('bulk update with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/registrants/bulk',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'attendeeCode': 'ABC12', 'name': 'test'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.registrant.bulkUpdate(
            pigeonholeId: 1,
            registrantForms: [
              RegistrantForm(
                attendeeCode: 'ABC12',
                customProfileField: CustomProfileField(
                  fields: {'name': 'test'},
                ),
              )
            ],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('bulk update with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/registrants/bulk',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'attendeeCode': 'ABC12', 'name': 'test'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.registrant.bulkUpdate(
            pigeonholeId: 1,
            workspaceId: 1,
            registrantForms: [
              RegistrantForm(
                attendeeCode: 'ABC12',
                customProfileField: CustomProfileField(
                  fields: {'name': 'test'},
                ),
              )
            ],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('bulk update with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/registrants/bulk',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          data: {
            'data': [
              {'attendeeCode': 'ABC12', 'name': 'test'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.registrant.bulkUpdate(
              pigeonholeId: 1,
              registrantForms: [
                RegistrantForm(
                  attendeeCode: 'ABC12',
                  customProfileField: CustomProfileField(
                    fields: {'name': 'test'},
                  ),
                )
              ],
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
