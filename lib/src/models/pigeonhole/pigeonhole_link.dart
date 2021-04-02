import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/enums/pigeonhole_link_access_level.dart';

part 'pigeonhole_link.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PigeonholeLink implements CastableToJson {
  PigeonholeLinkAccessLevel? accessLevel;
  String? url;

  PigeonholeLink({
    this.accessLevel,
    this.url,
  });

  factory PigeonholeLink.fromJson(Map<String, dynamic> json) =>
      _$PigeonholeLinkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PigeonholeLinkToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
