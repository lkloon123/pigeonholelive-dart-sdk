import 'package:pigeonholelive_sdk/src/auth/auth_interface.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';
import 'package:pigeonholelive_sdk/src/utils/enum_helper.dart';

enum ApiUrlKey {
  LIST_PIGEONHOLE,
  CREATE_PIGEONHOLE,
  INSPECT_PIGEONHOLE,
  UPDATE_PIGEONHOLE,

  LIST_SESSION,
  CREATE_SESSION,
  INSPECT_SESSION,
  UPDATE_SESSION,
  START_A_SESSION,
  LIST_NESTED_SESSION,
  NEST_SESSION,
  REPLACE_NEST_SESSION,
  LIST_SPEAKER_IN_SESSION,
  ADD_SPEAKER_IN_SESSION,
  REPLACE_SPEAKER_IN_SESSION,
  GENERATE_ONE_TIME_LINK,
  DELETE_ONE_TIME_LINK,
  LIST_ONE_TIME_LINK,
  GET_INSIGHT,

  LIST_SPEAKER,
  CREATE_SPEAKER,
  UPDATE_SPEAKER,

  LIST_WORKSPACE,
  INSPECT_WORKSPACE,
}

class ApiUrl {
  static AuthInterface get _auth =>
      ServiceProviderManager.instance.getIt.get<AuthInterface>();

  static String get(ApiUrlKey key, [int? workspaceId]) {
    if (_auth.authType() == AuthType.oAuth) {
      return _OAuthApiUrl.urls[EnumHelper.getValue(key)]!.replaceAll(
        ':workspaceId',
        workspaceId.toString(),
      );
    }

    return _WorkspaceApiUrl.urls[EnumHelper.getValue(key)]!;
  }
}

class _WorkspaceApiUrl {
  static Map<String, String> urls = {
    'LIST_PIGEONHOLE': 'pigeonholes',
    'CREATE_PIGEONHOLE': 'pigeonholes',
    'INSPECT_PIGEONHOLE': 'pigeonholes/:pigeonholeId',
    'UPDATE_PIGEONHOLE': 'pigeonholes/:pigeonholeId/update',

    'LIST_SESSION': 'pigeonholes/:pigeonholeId/sessions',
    'CREATE_SESSION': 'pigeonholes/:pigeonholeId/sessions',
    'INSPECT_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId',
    'UPDATE_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId/update',
    'START_A_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId/start',
    'LIST_NESTED_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/sessions',
    'NEST_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/sessions',
    'REPLACE_NEST_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/sessions',
    'LIST_SPEAKER_IN_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/speakers',
    'ADD_SPEAKER_IN_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/speakers',
    'REPLACE_SPEAKER_IN_SESSION': 'pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/speakers',
    'GENERATE_ONE_TIME_LINK': 'pigeonholes/:pigeonholeId/sessions/:sessionId/one-time-links/generate',
    'DELETE_ONE_TIME_LINK': 'pigeonholes/:pigeonholeId/sessions/:sessionId/one-time-links/:token',
    'LIST_ONE_TIME_LINK': 'pigeonholes/:pigeonholeId/sessions/:sessionId/one-time-links',
    'GET_INSIGHT': 'pigeonholes/:pigeonholeId/sessions/:sessionId/insights',

    'LIST_SPEAKER': 'pigeonholes/:pigeonholeId/speakers',
    'CREATE_SPEAKER': 'pigeonholes/:pigeonholeId/speakers',
    'UPDATE_SPEAKER': 'pigeonholes/:pigeonholeId/speakers/:speakerId/update',
  };
}

class _OAuthApiUrl {
  static Map<String, String> urls = {
    'LIST_PIGEONHOLE': 'workspaces/:workspaceId/pigeonholes',
    'CREATE_PIGEONHOLE': 'workspaces/:workspaceId/pigeonholes',
    'INSPECT_PIGEONHOLE': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId',
    'UPDATE_PIGEONHOLE': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/update',

    'LIST_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions',
    'CREATE_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions',
    'INSPECT_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId',
    'UPDATE_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/update',
    'START_A_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/start',
    'LIST_NESTED_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/sessions',
    'NEST_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/sessions',
    'REPLACE_NEST_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/sessions',
    'LIST_SPEAKER_IN_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/speakers',
    'ADD_SPEAKER_IN_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/speakers',
    'REPLACE_SPEAKER_IN_SESSION': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/relationships/speakers',
    'GENERATE_ONE_TIME_LINK': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/one-time-links/generate',
    'DELETE_ONE_TIME_LINK': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/one-time-links/:token',
    'LIST_ONE_TIME_LINK': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/one-time-links',
    'GET_INSIGHT': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/sessions/:sessionId/insights',

    'LIST_SPEAKER': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/speakers',
    'CREATE_SPEAKER': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/speakers',
    'UPDATE_SPEAKER': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/speakers/:speakerId/update',

    'LIST_WORKSPACE': 'workspaces',
    'INSPECT_WORKSPACE': 'workspaces/:workspaceId',
  };
}