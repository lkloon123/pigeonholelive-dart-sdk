import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/date_time_converter.dart';

part 'one_time_link.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
@DateTimeConverter()
class OneTimeLink implements CastableToJson {
  @JsonKey(name: 'for')
  String? oneTimeLinkFor;
  String? token;
  DateTime? expiresAt;
  String? expiresAtUnix;
  bool? used;
  String? link;

  OneTimeLink({
    this.oneTimeLinkFor,
    this.token,
    this.expiresAt,
    this.expiresAtUnix,
    this.used,
    this.link,
  });

  factory OneTimeLink.fromJson(Map<String, dynamic> json) =>
      _$OneTimeLinkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OneTimeLinkToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
