import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'pigeonhole_error.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PigeonholeError implements CastableToJson {
  int? code;
  String? message;

  PigeonholeError({
    this.code,
    this.message,
  });

  factory PigeonholeError.fromJson(Map<String, dynamic> json) =>
      _$PigeonholeErrorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PigeonholeErrorToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
