import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/models/registrant/forms/registrant_form.dart';
import 'package:pigeonholelive_sdk/src/models/registrant/registrant.dart';
import 'package:pigeonholelive_sdk/src/modules/module.dart';
import 'package:pigeonholelive_sdk/src/utils/api_url.dart';
import 'package:pigeonholelive_sdk/src/utils/pagination_helper.dart';
import 'package:pigeonholelive_sdk/src/utils/parameter_builder.dart';

abstract class RegistrantModuleInterface {
  Future<PaginationResult<Registrant>> list({
    required int pigeonholeId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });

  Future<Registrant> create({
    required int pigeonholeId,
    required Registrant registrant,
    int? workspaceId,
  });

  Future<Registrant> update({
    required int pigeonholeId,
    required Registrant registrant,
    int? workspaceId,
  });

  Future<void> delete({
    required int pigeonholeId,
    required int registrantId,
    int? workspaceId,
  });

  Future<void> bulkUpdate({
    required int pigeonholeId,
    required List<RegistrantForm> registrantForms,
    int? workspaceId,
  });
}

class RegistrantImpl extends Module implements RegistrantModuleInterface {
  @override
  Future<PaginationResult<Registrant>> list({
    required int pigeonholeId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_REGISTRANT, workspaceId)
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

    var paginationResult = PaginationResult<Registrant>.fromJson(
      response.data,
      (data) => Registrant.fromJson(data),
    );

    return PaginationHelper<PaginationResult<Registrant>>(
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
  Future<Registrant> create({
    required int pigeonholeId,
    required Registrant registrant,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_REGISTRANT, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: registrant.toJson(),
    );

    return Registrant.fromJson(response.data);
  }

  @override
  Future<Registrant> update({
    required int pigeonholeId,
    required Registrant registrant,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.UPDATE_REGISTRANT, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':registrantId', registrant.id.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: registrant.toJson(),
    );

    return Registrant.fromJson(response.data);
  }

  @override
  Future<void> delete({
    required int pigeonholeId,
    required int registrantId,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.DELETE_REGISTRANT, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':registrantId', registrantId.toString());

    await transmitter.send(
      method: HttpMethod.delete,
      uri: uri,
    );
  }

  @override
  Future<void> bulkUpdate({
    required int pigeonholeId,
    required List<RegistrantForm> registrantForms,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.BULK_UPDATE_REGISTRANT, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: {
        'data': registrantForms.map((value) => value.toJson()).toList(),
      },
    );
  }
}
