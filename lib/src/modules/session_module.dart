import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/chat.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/live_session.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_multiple_choice.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/qna.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/modules/module.dart';
import 'package:pigeonholelive_sdk/src/utils/api_url.dart';
import 'package:pigeonholelive_sdk/src/utils/pagination_helper.dart';
import 'package:pigeonholelive_sdk/src/utils/parameter_builder.dart';

abstract class SessionModuleInterface {
  Future<PaginationResult<LiveSession>> list({
    required int pigeonholeId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });

  Future<LiveSession> create({
    required int pigeonholeId,
    required LiveSession liveSession,
    int? workspaceId,
  });

  Future<LiveSession> inspect({
    required int pigeonholeId,
    required int sessionId,
    int? workspaceId,
  });

  Future<LiveSession> update({
    required int pigeonholeId,
    required LiveSession liveSession,
    int? workspaceId,
  });

  Future<void> startASession({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
  });
}

class SessionImpl extends Module implements SessionModuleInterface {
  @override
  Future<PaginationResult<LiveSession>> list({
    required int pigeonholeId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .addFiltersToParams(filter: filter)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = PaginationResult<LiveSession>.fromJson(
      response.data,
      (e) {
        if (e is Map<String, dynamic> && e.containsKey('type')) {
          if (e['type'] == 'qna') {
            return Qna.fromJson(e);
          }

          if (e['type'] == 'poll_multiple_choice') {
            return PollMultipleChoice.fromJson(e);
          }

          if (e['type'] == 'chat') {
            return Chat.fromJson(e);
          }
        }
        return LiveSession.fromJson(e);
      },
    );

    return PaginationHelper<LiveSession>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return list(
        pigeonholeId: pigeonholeId,
        workspaceId: workspaceId,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }

  @override
  Future<LiveSession> create({
    required int pigeonholeId,
    required LiveSession liveSession,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.CREATE_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: liveSession.toJson(),
    );

    return LiveSession.fromJson(response.data);
  }

  @override
  Future<LiveSession> inspect({
    required int pigeonholeId,
    required int sessionId,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.INSPECT_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', sessionId.toString());

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
    );

    return LiveSession.fromJson(response.data);
  }

  @override
  Future<LiveSession> update({
    required int pigeonholeId,
    required LiveSession liveSession,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.UPDATE_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSession.id.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: liveSession.toJson(),
    );

    return LiveSession.fromJson(response.data);
  }

  @override
  Future<void> startASession({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.START_A_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
    );
  }
}
