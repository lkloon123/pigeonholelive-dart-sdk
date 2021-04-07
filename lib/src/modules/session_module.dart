import 'package:pigeonholelive_sdk/src/factory/live_session_factory.dart';
import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/forms/one_time_link_form.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/forms/speaker_form.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/insight/insight.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/live_session.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/one_time_link.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/insight_pagination_result.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/models/speaker/speaker.dart';
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
    required int liveSessionId,
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

  Future<PaginationResult<LiveSession>> listNestedSession({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });

  Future<void> nestSession({
    required int pigeonholeId,
    required int liveSessionId,
    required List<int> liveSessionIdsForNest,
    int? workspaceId,
  });

  Future<void> replaceNestedSession({
    required int pigeonholeId,
    required int liveSessionId,
    List<int> liveSessionIdsForNest = const <int>[],
    int? workspaceId,
  });

  Future<PaginationResult<Speaker>> listSpeakers({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });

  Future<void> addSpeaker({
    required int pigeonholeId,
    required int liveSessionId,
    required List<SpeakerForm> speakers,
    int? workspaceId,
  });

  Future<void> replaceSpeaker({
    required int pigeonholeId,
    required int liveSessionId,
    List<SpeakerForm> speakers = const <SpeakerForm>[],
    int? workspaceId,
  });

  Future<OneTimeLink> generateOneTimeLink({
    required int pigeonholeId,
    required int liveSessionId,
    required OneTimeLinkForm oneTimeLinkForm,
    int? workspaceId,
  });

  Future<void> deleteOneTimeLink({
    required int pigeonholeId,
    required int liveSessionId,
    required String token,
    int? workspaceId,
  });

  Future<PaginationResult<OneTimeLink>> listOneTimeLinks({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });

  Future<InsightPaginationResult<Insight>> insights({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
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
      LiveSessionFactory.make,
    );

    return PaginationHelper<PaginationResult<LiveSession>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return list(
        pigeonholeId: pigeonholeId,
        workspaceId: workspaceId,
        filter: filter,
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

    return LiveSessionFactory.make(response.data);
  }

  @override
  Future<LiveSession> inspect({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.INSPECT_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
    );

    return LiveSessionFactory.make(response.data);
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

    return LiveSessionFactory.make(response.data);
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

  @override
  Future<PaginationResult<LiveSession>> listNestedSession({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_NESTED_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

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
      LiveSessionFactory.make,
    );

    return PaginationHelper<PaginationResult<LiveSession>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return listNestedSession(
        pigeonholeId: pigeonholeId,
        liveSessionId: liveSessionId,
        workspaceId: workspaceId,
        filter: filter,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }

  @override
  Future<void> nestSession({
    required int pigeonholeId,
    required int liveSessionId,
    required List<int> liveSessionIdsForNest,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.NEST_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: {
        'data': liveSessionIdsForNest.map((value) => {'id': value}).toList(),
      },
    );
  }

  @override
  Future<void> replaceNestedSession({
    required int pigeonholeId,
    required int liveSessionId,
    List<int> liveSessionIdsForNest = const <int>[],
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.REPLACE_NEST_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    await transmitter.send(
      method: HttpMethod.patch,
      uri: uri,
      params: {
        'data': liveSessionIdsForNest.map((value) => {'id': value}).toList(),
      },
    );
  }

  @override
  Future<PaginationResult<Speaker>> listSpeakers({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_SPEAKER_IN_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .addFiltersToParams(filter: filter)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = PaginationResult<Speaker>.fromJson(
      response.data,
      (data) => Speaker.fromJson(data),
    );

    return PaginationHelper<PaginationResult<Speaker>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return listSpeakers(
        pigeonholeId: pigeonholeId,
        liveSessionId: liveSessionId,
        workspaceId: workspaceId,
        filter: filter,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }

  @override
  Future<void> addSpeaker({
    required int pigeonholeId,
    required int liveSessionId,
    required List<SpeakerForm> speakers,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.ADD_SPEAKER_IN_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: {
        'data': speakers.map((value) => value.toJson()).toList(),
      },
    );
  }

  @override
  Future<void> replaceSpeaker({
    required int pigeonholeId,
    required int liveSessionId,
    List<SpeakerForm> speakers = const <SpeakerForm>[],
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.REPLACE_SPEAKER_IN_SESSION, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    await transmitter.send(
      method: HttpMethod.patch,
      uri: uri,
      params: {
        'data': speakers.map((value) => value.toJson()).toList(),
      },
    );
  }

  @override
  Future<OneTimeLink> generateOneTimeLink({
    required int pigeonholeId,
    required int liveSessionId,
    required OneTimeLinkForm oneTimeLinkForm,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.GENERATE_ONE_TIME_LINK, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: oneTimeLinkForm.toJson(),
    );

    return OneTimeLink.fromJson(response.data);
  }

  @override
  Future<void> deleteOneTimeLink({
    required int pigeonholeId,
    required int liveSessionId,
    required String token,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.DELETE_ONE_TIME_LINK, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString())
        .replaceAll(':token', token);

    await transmitter.send(
      method: HttpMethod.delete,
      uri: uri,
    );
  }

  @override
  Future<PaginationResult<OneTimeLink>> listOneTimeLinks({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_ONE_TIME_LINK, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .addFiltersToParams(filter: filter)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = PaginationResult<OneTimeLink>.fromJson(
      response.data,
      (data) => OneTimeLink.fromJson(data),
    );

    return PaginationHelper<PaginationResult<OneTimeLink>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return listOneTimeLinks(
        pigeonholeId: pigeonholeId,
        liveSessionId: liveSessionId,
        workspaceId: workspaceId,
        filter: filter,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }

  @override
  Future<InsightPaginationResult<Insight>> insights({
    required int pigeonholeId,
    required int liveSessionId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.GET_INSIGHT, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':sessionId', liveSessionId.toString());

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .addFiltersToParams(filter: filter)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = InsightPaginationResult<Insight>.fromJson(
      response.data,
      (data) => Insight.fromJson(data),
    );

    return PaginationHelper<InsightPaginationResult<Insight>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return insights(
        pigeonholeId: pigeonholeId,
        liveSessionId: liveSessionId,
        workspaceId: workspaceId,
        filter: filter,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }
}
