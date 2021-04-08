import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/models/subscription/subscription.dart';
import 'package:pigeonholelive_sdk/src/modules/module.dart';
import 'package:pigeonholelive_sdk/src/utils/api_url.dart';
import 'package:pigeonholelive_sdk/src/utils/pagination_helper.dart';
import 'package:pigeonholelive_sdk/src/utils/parameter_builder.dart';

abstract class SubscriptionModuleInterface {
  Future<PaginationResult<Subscription>> list({
    int? workspaceId,
    PaginationMeta? paginationMeta,
  });

  Future<Subscription> inspect({
    required int subscriptionId,
    int? workspaceId,
  });
}

class SubscriptionImpl extends Module implements SubscriptionModuleInterface {
  @override
  Future<PaginationResult<Subscription>> list({
    int? workspaceId,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_SUBSCRIPTION, workspaceId);

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = PaginationResult<Subscription>.fromJson(
      response.data,
      (data) => Subscription.fromJson(data),
    );

    return PaginationHelper<PaginationResult<Subscription>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return list(
        workspaceId: workspaceId,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }

  @override
  Future<Subscription> inspect({
    required int subscriptionId,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.INSPECT_SUBSCRIPTION, workspaceId)
        .replaceAll(':subscriptionId', subscriptionId.toString());

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
    );

    return Subscription.fromJson(response.data);
  }
}
