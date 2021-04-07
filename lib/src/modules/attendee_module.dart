import 'package:pigeonholelive_sdk/src/http/http_method.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/attendee.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/forms/attendee_form.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/profile_field/profile_field.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';
import 'package:pigeonholelive_sdk/src/modules/module.dart';
import 'package:pigeonholelive_sdk/src/utils/api_url.dart';
import 'package:pigeonholelive_sdk/src/utils/pagination_helper.dart';
import 'package:pigeonholelive_sdk/src/utils/parameter_builder.dart';

abstract class AttendeeModuleInterface {
  Future<PaginationResult<Attendee>> list({
    required int pigeonholeId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  });

  Future<void> bulkUpdate({
    required int pigeonholeId,
    required List<AttendeeForm> attendeeForms,
    int? workspaceId,
  });

  Future<PaginationResult<ProfileField>> listProfileField({
    required int pigeonholeId,
    int? workspaceId,
    PaginationMeta? paginationMeta,
  });

  Future<ProfileField> createProfileField({
    required int pigeonholeId,
    required ProfileField profileField,
    int? workspaceId,
  });

  Future<void> bulkCreateProfileField({
    required int pigeonholeId,
    required List<ProfileField> profileFields,
    int? workspaceId,
  });

  Future<void> deleteProfileField({
    required int pigeonholeId,
    required String fieldName,
    int? workspaceId,
  });
}

class AttendeeImpl extends Module implements AttendeeModuleInterface {
  @override
  Future<PaginationResult<Attendee>> list({
    required int pigeonholeId,
    int? workspaceId,
    dynamic? filter,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_ATTENDEE, workspaceId)
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

    var paginationResult = PaginationResult<Attendee>.fromJson(
      response.data,
      (data) => Attendee.fromJson(data),
    );

    return PaginationHelper<PaginationResult<Attendee>>(
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
  Future<void> bulkUpdate({
    required int pigeonholeId,
    required List<AttendeeForm> attendeeForms,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.BULK_UPDATE_ATTENDEE, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    await transmitter.send(
      method: HttpMethod.patch,
      uri: uri,
      params: {
        'data': attendeeForms.map((value) => value.toJson()).toList(),
      },
    );
  }

  @override
  Future<PaginationResult<ProfileField>> listProfileField({
    required int pigeonholeId,
    int? workspaceId,
    PaginationMeta? paginationMeta,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.LIST_PROFILE_FIELD, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    var params = ParameterBuilder()
        .addPaginationToParams(paginationMeta: paginationMeta)
        .parameters;

    var response = await transmitter.send(
      method: HttpMethod.get,
      uri: uri,
      params: params,
    );

    var paginationResult = PaginationResult<ProfileField>.fromJson(
      response.data,
      (data) => ProfileField.fromJson(data),
    );

    return PaginationHelper<PaginationResult<ProfileField>>(
      paginationResult: paginationResult,
    ).setNextPage(() {
      return listProfileField(
        pigeonholeId: pigeonholeId,
        workspaceId: workspaceId,
        paginationMeta: paginationResult.paginationMeta,
      );
    });
  }

  @override
  Future<ProfileField> createProfileField({
    required int pigeonholeId,
    required ProfileField profileField,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.CREATE_PROFILE_FIELD, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    var response = await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: profileField.toJson(),
    );

    return ProfileField.fromJson(response.data);
  }

  @override
  Future<void> bulkCreateProfileField({
    required int pigeonholeId,
    required List<ProfileField> profileFields,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.BULK_CREATE_PROFILE_FIELD, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString());

    await transmitter.send(
      method: HttpMethod.post,
      uri: uri,
      params: {
        'data': profileFields.map((value) => value.toJson()).toList(),
      },
    );
  }

  @override
  Future<void> deleteProfileField({
    required int pigeonholeId,
    required String fieldName,
    int? workspaceId,
  }) async {
    var uri = ApiUrl.get(ApiUrlKey.DELETE_PROFILE_FIELD, workspaceId)
        .replaceAll(':pigeonholeId', pigeonholeId.toString())
        .replaceAll(':fieldName', fieldName);

    await transmitter.send(
      method: HttpMethod.delete,
      uri: uri,
    );
  }
}
