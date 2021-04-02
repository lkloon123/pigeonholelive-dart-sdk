import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/models/pigeonhole/pigeonhole.dart';
import 'package:pigeonholelive_sdk/src/modules/module.dart';
import 'package:pigeonholelive_sdk/src/utils/api_url.dart';
import 'package:pigeonholelive_sdk/src/utils/pagination_helper.dart';
import 'package:pigeonholelive_sdk/src/utils/parameter_builder.dart';

abstract class PigeonholeModuleInterface {
  Future<PaginationResult<Pigeonhole>> list({
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });

  Future<Pigeonhole> create({required Pigeonhole pigeonhole, int? workspaceId});

  Future<Pigeonhole> inspect({required int pigeonholeId, int? workspaceId});

  Future<Pigeonhole> update({required Pigeonhole pigeonhole, int? workspaceId});
}

class PigeonholeImpl extends Module implements PigeonholeModuleInterface {
  @override
  Future<PaginationResult<Pigeonhole>> list({
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_PIGEONHOLE, workspaceId);

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .addFiltersToParams(filter: filter)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = PaginationResult<Pigeonhole>.fromJson(
      response.data,
      (data) => Pigeonhole.fromJson(data),
    );

    return PaginationHelper<Pigeonhole>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return list(
        workspaceId: workspaceId,
        filter: filter,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }

  @override
  Future<Pigeonhole> create({
    required Pigeonhole pigeonhole,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.CREATE_PIGEONHOLE, workspaceId);

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: pigeonhole.toJson(),
    );

    return Pigeonhole.fromJson(response.data);
  }

  @override
  Future<Pigeonhole> inspect({
    required int pigeonholeId,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.INSPECT_PIGEONHOLE, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
    );

    return Pigeonhole.fromJson(response.data);
  }

  @override
  Future<Pigeonhole> update({
    required Pigeonhole pigeonhole,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.UPDATE_PIGEONHOLE, workspaceId)
        .replaceAll(':pigeonholeId', pigeonhole.id.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: pigeonhole.toJson(),
    );

    return Pigeonhole.fromJson(response.data);
  }
}
