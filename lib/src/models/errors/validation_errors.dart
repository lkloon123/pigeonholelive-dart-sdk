import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/errors/pigeonhole_error.dart';
import 'package:pigeonholelive_sdk/src/models/errors/validation_error.dart';

part 'validation_errors.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ValidationErrors extends PigeonholeError implements CastableToJson {
  List<ValidationError>? errors;

  ValidationErrors({
    this.errors,
    int? code,
    String? message,
  }) : super(code: code, message: message);

  factory ValidationErrors.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ValidationErrorsToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
