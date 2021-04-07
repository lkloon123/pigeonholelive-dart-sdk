import 'package:pigeonholelive_sdk/src/auth/auth_interface.dart';
import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/models/workspace/workspace.dart';
import 'package:pigeonholelive_sdk/src/modules/module.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';
import 'package:pigeonholelive_sdk/src/utils/api_url.dart';
import 'package:pigeonholelive_sdk/src/utils/pagination_helper.dart';
import 'package:pigeonholelive_sdk/src/utils/parameter_builder.dart';

abstract class WorkspaceModuleInterface {
  Future<PaginationResult<Workspace>> list({PaginationMeta? paginationMeta});

  Future<Workspace> inspect({required int workspaceId});
}

class WorkspaceImpl extends Module implements WorkspaceModuleInterface {
  AuthInterface get _auth =>
      ServiceProviderManager.instance.getIt.get<AuthInterface>();

  @override
  Future<PaginationResult<Workspace>> list({PaginationMeta? paginationMeta}) async {
    throwIfWorkspaceToken();

    var uri = ApiUrl.get(ApiUrlKey.LIST_WORKSPACE);

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = PaginationResult<Workspace>.fromJson(
      response.data,
      (data) => Workspace.fromJson(data),
    );

    return PaginationHelper<PaginationResult<Workspace>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return list(paginationMeta: paginationResult.paginationMeta);
    });
  }

  @override
  Future<Workspace> inspect({required int workspaceId}) async {
    throwIfWorkspaceToken();

    var uri = ApiUrl.get(ApiUrlKey.INSPECT_WORKSPACE, workspaceId);

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
    );

    return Workspace.fromJson(response.data);
  }

  void throwIfWorkspaceToken() {
    if (_auth.authType() == AuthType.token) {
      throw Exception('Workspace token is not supported for this method.');
    }
  }
}
