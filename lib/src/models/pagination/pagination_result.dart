import 'dart:convert';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:pigeonholelive_sdk/src/exceptions/no_next_page_exception.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_link.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_meta.dart';

typedef NextPageCallback<T> = Future<PaginationResult<T>> Function();
typedef FromJsonCallback<T> = T Function(Map<String, dynamic>);

// cannot use json serializable as it does not support generic types
class PaginationResult<T> implements CastableToJson {
  List<T>? data;
  PaginationLink? paginationLink;
  PaginationMeta? paginationMeta;
  NextPageCallback<T> nextPage = () {
    throw NoNextPageException();
  };

  PaginationResult({
    this.data,
    this.paginationLink,
    this.paginationMeta,
  });

  factory PaginationResult.fromJson(
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

    return PaginationResult<T>(
      data: data,
      paginationLink: json['links'] == null
          ? null
          : PaginationLink.fromJson(json['links'] as Map<String, dynamic>),
      paginationMeta: json['meta'] == null
          ? null
          : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull(
      'data',
      data?.map((dynamic e) => e is CastableToJson ? e.toJson() : e).toList(),
    );
    writeNotNull('links', paginationLink?.toJson());
    writeNotNull('meta', paginationMeta?.toJson());
    return val;
  }

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
