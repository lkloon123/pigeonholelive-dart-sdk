import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'consent.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Consent implements CastableToJson {
  bool? obtained;
  DateTime? obtainedAt;

  Consent({
    this.obtained,
    this.obtainedAt,
  });

  factory Consent.fromJson(Map<String, dynamic> json) =>
      _$ConsentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ConsentToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
