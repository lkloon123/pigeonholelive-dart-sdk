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

    'LIST_SPEAKER': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/speakers',
    'CREATE_SPEAKER': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/speakers',
    'UPDATE_SPEAKER': 'workspaces/:workspaceId/pigeonholes/:pigeonholeId/speakers/:speakerId/update',

    'LIST_WORKSPACE': 'workspaces',
    'INSPECT_WORKSPACE': 'workspaces/:workspaceId',
  };
}