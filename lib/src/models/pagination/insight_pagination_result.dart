import 'dart:convert';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_link.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';

// cannot use json serializable as it does not support generic types
class InsightPaginationResult<T> extends PaginationResult<T>
    implements CastableToJson {
  LiveSession? liveSession;

  InsightPaginationResult({
    List<T>? data,
    PaginationLink? paginationLink,
    PaginationMeta? paginationMeta,
    this.liveSession,
  }) : super(
          data: data,
          paginationLink: paginationLink,
          paginationMeta: paginationMeta,
        );

  factory InsightPaginationResult.fromJson(
    Map<String, dynamic> json, [
    FromJsonCallback<T>? dataFromJson,
  ]) {
    var data;
    if (json['data'] != null) {
      if (dataFromJson != null) {
        data = List<T>.from(
          (json['data'] as List).map((e) {
            return dataFromJson(e);
          }).toList(),
        );
      } else {
        data = json['data'] as List<dynamic>;
      }
    }

    return InsightPaginationResult<T>(
      data: data,
      paginationLink: json['links'] == null
          ? null
          : PaginationLink.fromJson(json['links'] as Map<String, dynamic>),
      paginationMeta: json['meta'] == null
          ? null
          : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
      liveSession: json['session'] == null
          ? null
          : LiveSession.fromJson(json['session'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final val = super.toJson();

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('session', liveSession?.toJson());
    return val;
  }

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
