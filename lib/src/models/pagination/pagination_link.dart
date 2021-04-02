import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'pagination_link.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PaginationLink implements CastableToJson {
  String? next;

  PaginationLink({
    this.next,
  });

  factory PaginationLink.fromJson(Map<String, dynamic> json) =>
      _$PaginationLinkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginationLinkToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
