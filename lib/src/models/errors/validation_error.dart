import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'validation_error.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ValidationError implements CastableToJson {
  String? field;
  String? message;

  ValidationError({
    this.field,
    this.message,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
