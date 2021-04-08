import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/models/speaker/speaker.dart';
import 'package:pigeonholelive_sdk/src/modules/module.dart';
import 'package:pigeonholelive_sdk/src/utils/api_url.dart';
import 'package:pigeonholelive_sdk/src/utils/pagination_helper.dart';
import 'package:pigeonholelive_sdk/src/utils/parameter_builder.dart';

abstract class SpeakerModuleInterface {
  Future<PaginationResult<Speaker>> list({
    required int pigeonholeId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });

  Future<Speaker> create({
    required Speaker speaker,
    required int pigeonholeId,
    int? workspaceId,
  });

  Future<Speaker> update({
    required Speaker speaker,
    required int pigeonholeId,
    int? workspaceId,
  });
}

class SpeakerImpl extends Module implements SpeakerModuleInterface {
  @override
  Future<PaginationResult<Speaker>> list({
    required int pigeonholeId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_SPEAKER, workspaceId)
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

    var paginationResult = PaginationResult<Speaker>.fromJson(
      response.data,
      (data) => Speaker.fromJson(data),
    );

    return PaginationHelper<PaginationResult<Speaker>>(
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
  Future<Speaker> create({
    required Speaker speaker,
    required int pigeonholeId,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.CREATE_SPEAKER, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: speaker.toJson(),
    );

    return Speaker.fromJson(response.data);
  }

  @override
  Future<Speaker> update({
    required Speaker speaker,
    required int pigeonholeId,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.UPDATE_SPEAKER, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':speakerId', speaker.id.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: speaker.toJson(),
    );

    return Speaker.fromJson(response.data);
  }
}
