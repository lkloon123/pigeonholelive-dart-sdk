import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'registrant.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Registrant implements CastableToJson {
  int? id;
  String? attendeeCode;
  bool? signedIn;
  CustomProfileField? customProfileField;

  Registrant({
    this.id,
    this.attendeeCode,
    this.signedIn,
    this.customProfileField,
  });

  factory Registrant.fromJson(Map<String, dynamic> json) {
    var registrant = _$RegistrantFromJson(json);
    registrant.customProfileField = CustomProfileField.fromJson(json
      ..removeWhere((key, value) {
        return key == 'id' || key == 'attendeeCode' || key == 'signedIn';
      }));
    return registrant;
  }

  @override
  Map<String, dynamic> toJson() {
    var registrantToJson = _$RegistrantToJson(this);
    registrantToJson.addAll(customProfileField?.toJson() ?? {});
    return registrantToJson;
  }

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
