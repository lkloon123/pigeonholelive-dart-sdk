import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/branding/branding.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/modules/module.dart';
import 'package:pigeonholelive_sdk/src/utils/api_url.dart';
import 'package:pigeonholelive_sdk/src/utils/pagination_helper.dart';
import 'package:pigeonholelive_sdk/src/utils/parameter_builder.dart';

abstract class CustomBrandingModuleInterface {
  Future<PaginationResult<Branding>> list({
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });
}

class CustomBrandingImpl extends Module
    implements CustomBrandingModuleInterface {
  @override
  Future<PaginationResult<Branding>> list({
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_CUSTOM_BRANDING, workspaceId);

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .addFiltersToParams(filter: filter)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = PaginationResult<Branding>.fromJson(
      response.data,
      (data) => Branding.fromJson(data),
    );

    return PaginationHelper<PaginationResult<Branding>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return list(
        workspaceId: workspaceId,
        filter: filter,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }
}
