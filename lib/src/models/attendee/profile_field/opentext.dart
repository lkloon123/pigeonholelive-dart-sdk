import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/profile_field/profile_field.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'opentext.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Opentext extends ProfileField implements CastableToJson {
  Opentext({
    String? name,
    bool? required,
    String? type,
    int? order,
  }) : super(
          name: name,
          required: required,
          type: type,
          order: order,
        );

  factory Opentext.fromJson(Map<String, dynamic> json) =>
      _$OpentextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OpentextToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
