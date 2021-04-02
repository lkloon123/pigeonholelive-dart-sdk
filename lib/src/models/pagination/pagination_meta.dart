import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'pagination_meta.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PaginationMeta implements CastableToJson {
  int? perPage;
  String? nextCursor;
  bool? hasMore;

  PaginationMeta({
    this.perPage,
    this.nextCursor,
    this.hasMore,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}