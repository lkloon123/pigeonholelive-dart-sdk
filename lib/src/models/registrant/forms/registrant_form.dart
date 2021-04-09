import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/custom_profile_field.dart';

part 'registrant_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RegistrantForm implements CastableToJson {
  String? attendeeCode;
  @JsonKey(ignore: true)
  CustomProfileField? customProfileField;

  RegistrantForm({
    this.attendeeCode,
    this.customProfileField,
  });

  factory RegistrantForm.fromJson(Map<String, dynamic> json) {
    var registrant = _$RegistrantFormFromJson(json);
    registrant.customProfileField = CustomProfileField.fromJson(
        json..removeWhere((key, value) => key == 'attendeeCode'));
    return registrant;
  }

  @override
  Map<String, dynamic> toJson() {
    var registrantToJson = _$RegistrantFormToJson(this);
    registrantToJson.addAll(customProfileField?.toJson() ?? {});
    return registrantToJson;
  }

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
