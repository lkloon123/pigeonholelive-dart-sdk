import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'one_time_link_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OneTimeLinkForm implements CastableToJson {
  @JsonKey(name: 'for')
  String oneTimeLinkFor;
  int ttl;

  OneTimeLinkForm({
    required this.oneTimeLinkFor,
    required this.ttl,
  });

  factory OneTimeLinkForm.fromJson(Map<String, dynamic> json) =>
      _$OneTimeLinkFormFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OneTimeLinkFormToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
