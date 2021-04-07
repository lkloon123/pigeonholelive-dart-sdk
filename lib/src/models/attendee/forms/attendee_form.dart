import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/custom_profile_field.dart';

part 'attendee_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AttendeeForm implements CastableToJson {
  int? id;
  String? attendeeCode;
  @JsonKey(ignore: true)
  CustomProfileField? customProfileField;

  AttendeeForm({
    this.id,
    this.attendeeCode,
    this.customProfileField,
  });

  factory AttendeeForm.fromJson(Map<String, dynamic> json) {
    var attendee = _$AttendeeFormFromJson(json);
    attendee.customProfileField = CustomProfileField.fromJson(json
      ..removeWhere((key, value) {
        return key == 'id' || key == 'attendeeCode';
      }));
    return attendee;
  }

  @override
  Map<String, dynamic> toJson() {
    var attendeeToJson = _$AttendeeFormToJson(this);
    attendeeToJson.addAll(customProfileField?.toJson() ?? {});
    return attendeeToJson;
  }

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
