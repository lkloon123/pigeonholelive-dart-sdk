import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'profile_field.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ProfileField implements CastableToJson {
  String? name;
  bool? required;
  String? type;
  int? order;

  ProfileField({
    this.name,
    this.required,
    this.type,
    this.order,
  });

  factory ProfileField.fromJson(Map<String, dynamic> json) =>
      _$ProfileFieldFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileFieldToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
