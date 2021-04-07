import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/forms/attendee_form.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/profile_field/profile_field.dart';
import 'package:pigeonholelive_sdk/src/models/custom_profile_field.dart';
import 'package:test/test.dart';

import '../testing_utils.dart';

void main() {
  group('test Attendee Module', () {
    late var dioAdapter;

    setUpAll(() {
      dioAdapter = DioAdapter();
    });

    group('list', () {
      test('list with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/attendees',
          TestingUtils.mockResponse(200, 'attendee/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var attendees = await pigeonholeLive.attendee.list(pigeonholeId: 1);
        expect(
          attendees.data?.first.customProfileField?.get('property1'),
          equalsIgnoringCase('string'),
        );
      });

      test('list with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/attendees',
          TestingUtils.mockResponse(200, 'attendee/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var attendees = await pigeonholeLive.attendee.list(
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(
          attendees.data?.first.customProfileField?['property1'],
          equalsIgnoringCase('string'),
        );
      });

      test('list with error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/attendees',
          (request) {
            request.throws(
              502,
              DioError(
                error: 'random dio error',
                requestOptions: RequestOptions(path: 'xxx'),
              ),
            );
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.attendee.list(pigeonholeId: 1, workspaceId: 1);
          },
          throwsA(isA<PigeonholeException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('random dio error'),
          )),
        );
      });

      test('call list result with next page', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/attendees',
          TestingUtils.mockResponse(200, 'attendee/list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var attendees = await pigeonholeLive.attendee.list(pigeonholeId: 1);

        dioAdapter.onGet(
          '/pigeonholes/1/attendees',
          TestingUtils.mockResponse(200, 'attendee/list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        attendees = await attendees.nextPage();
        expect(
          attendees.data?.first.customProfileField?.get('property3'),
          equalsIgnoringCase('name'),
        );

        expect(
          () => attendees.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });

    group('bulk update', () {
      test('bulk update with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPatch(
          '/pigeonholes/1/attendees/bulk',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1, 'name': 'test'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.attendee.bulkUpdate(
            pigeonholeId: 1,
            attendeeForms: [
              AttendeeForm(
                id: 1,
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

        dioAdapter.onPatch(
          '/workspaces/1/pigeonholes/1/attendees/bulk',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'id': 1, 'name': 'test'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.attendee.bulkUpdate(
            pigeonholeId: 1,
            workspaceId: 1,
            attendeeForms: [
              AttendeeForm(
                id: 1,
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

        dioAdapter.onPatch(
          '/pigeonholes/1/attendees/bulk',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          data: {
            'data': [
              {'id': 1, 'name': 'test'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.attendee.bulkUpdate(
              pigeonholeId: 1,
              attendeeForms: [
                AttendeeForm(
                  id: 1,
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

    group('list profile field', () {
      test('list profile field with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/profile-fields',
          TestingUtils.mockResponse(200, 'attendee/profile_field_list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var profileFields = await pigeonholeLive.attendee.listProfileField(
          pigeonholeId: 1,
        );
        expect(
          profileFields.data?.first.name,
          equalsIgnoringCase('Organization'),
        );
      });

      test('list profile field with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/profile-fields',
          TestingUtils.mockResponse(200, 'attendee/profile_field_list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var profileFields = await pigeonholeLive.attendee.listProfileField(
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(
          profileFields.data?.first.name,
          equalsIgnoringCase('Organization'),
        );
      });

      test('list profile field with rate limited error', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/workspaces/1/pigeonholes/1/profile-fields',
          TestingUtils.mockErrorResponse(429, 'error/rate_limited.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.attendee.listProfileField(
              pigeonholeId: 1,
              workspaceId: 1,
            );
          },
          throwsA(isA<RateLimitedException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('API rate limit exceeded'),
          )),
        );
      });

      test('call list profile field result with next page', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onGet(
          '/pigeonholes/1/profile-fields',
          TestingUtils.mockResponse(200, 'attendee/profile_field_list.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        var profileFields = await pigeonholeLive.attendee.listProfileField(
          pigeonholeId: 1,
        );

        dioAdapter.onGet(
          '/pigeonholes/1/profile-fields',
          TestingUtils.mockResponse(200, 'attendee/profile_field_list2.json'),
          queryParameters: {'cursor': 'Y3Vyc29yXzk0OA=='},
          headers: TestingUtils.getTestHeaders(token),
        );

        profileFields = await profileFields.nextPage();
        expect(
          profileFields.data?.first.name,
          equalsIgnoringCase('name'),
        );

        expect(
          () => profileFields.nextPage(),
          throwsA(TypeMatcher<NoNextPageException>()),
        );
      });
    });

    group('create profile field', () {
      test('create profile field with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/profile-fields',
          TestingUtils.mockResponse(201, 'attendee/profile_field.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var profileField = await pigeonholeLive.attendee.createProfileField(
          profileField: ProfileField.fromJson(
            TestingUtils.readFixtureFile('attendee/profile_field.json'),
          ),
          pigeonholeId: 1,
        );
        expect(profileField.name, equalsIgnoringCase('Organization'));
      });

      test('create profile field with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/profile-fields',
          TestingUtils.mockResponse(201, 'attendee/profile_field.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        var profileField = await pigeonholeLive.attendee.createProfileField(
          profileField: ProfileField.fromJson(
            TestingUtils.readFixtureFile('attendee/profile_field.json'),
          ),
          pigeonholeId: 1,
          workspaceId: 1,
        );
        expect(profileField.name, equalsIgnoringCase('Organization'));
      });

      test('create profile field with throttling error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/profile-fields',
          TestingUtils.mockErrorResponse(503, 'error/throttling.json'),
          data: Matchers.any,
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.attendee.createProfileField(
              profileField: ProfileField.fromJson(
                TestingUtils.readFixtureFile('attendee/profile_field.json'),
              ),
              pigeonholeId: 1,
            );
          },
          throwsA(isA<ThrottlingException>().having(
            (error) => error.pigeonholeError.message,
            'error message',
            equalsIgnoringCase('Service Unavailable'),
          )),
        );
      });
    });

    group('bulk create profile field', () {
      test('bulk create profile field with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/profile-fields/bulk',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'name': 'name', 'type': 'opentext'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.attendee.bulkCreateProfileField(
            pigeonholeId: 1,
            profileFields: [ProfileField(name: 'name', type: 'opentext')],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('bulk create profile field with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/workspaces/1/pigeonholes/1/profile-fields/bulk',
          TestingUtils.mockResponse(204, null),
          data: {
            'data': [
              {'name': 'name', 'type': 'opentext'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.attendee.bulkCreateProfileField(
            pigeonholeId: 1,
            workspaceId: 1,
            profileFields: [ProfileField(name: 'name', type: 'opentext')],
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('bulk create profile field with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onPost(
          '/pigeonholes/1/profile-fields/bulk',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          data: {
            'data': [
              {'name': 'name', 'type': 'opentext'},
            ],
          },
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.attendee.bulkCreateProfileField(
              pigeonholeId: 1,
              profileFields: [ProfileField(name: 'name', type: 'opentext')],
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

    group('delete profile field', () {
      test('delete profile field with workspace token', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/pigeonholes/1/profile-fields/organization',
          TestingUtils.mockResponse(204, null),
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.attendee.deleteProfileField(
            pigeonholeId: 1,
            fieldName: 'organization',
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('delete profile field with oauth token', () async {
        var token = OAuthAccessToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/workspaces/1/pigeonholes/1/profile-fields/organization',
          TestingUtils.mockResponse(204, null),
          headers: TestingUtils.getTestHeaders(token),
        );

        try {
          await pigeonholeLive.attendee.deleteProfileField(
            pigeonholeId: 1,
            workspaceId: 1,
            fieldName: 'organization',
          );
        } catch (e) {
          fail(e.toString());
        }
      });

      test('delete profile field with server error', () async {
        var token = WorkspaceToken(token: 'xxx');
        var pigeonholeLive = TestingUtils.pigeonholeLive(token, dioAdapter);

        dioAdapter.onDelete(
          '/pigeonholes/1/profile-fields/organization',
          TestingUtils.mockErrorResponse(500, 'error/server.json'),
          headers: TestingUtils.getTestHeaders(token),
        );

        expect(
          () async {
            await pigeonholeLive.attendee.deleteProfileField(
              pigeonholeId: 1,
              fieldName: 'organization',
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
