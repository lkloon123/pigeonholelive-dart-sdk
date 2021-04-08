import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'branding.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Branding implements CastableToJson {
  int? id;
  String? name;
  String? customUrl;

  Branding({
    this.id,
    this.name,
    this.customUrl,
  });

  factory Branding.fromJson(Map<String, dynamic> json) =>
      _$BrandingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BrandingToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
