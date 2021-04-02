import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/enums/salutation.dart';

part 'speaker.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Speaker implements CastableToJson {
  int? id;
  Salutation? salutation;
  String? fullName;
  String? briefDescription;
  String? biography;

  Speaker({
    this.id,
    this.salutation,
    this.fullName,
    this.briefDescription,
    this.biography,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) =>
      _$SpeakerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SpeakerToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
