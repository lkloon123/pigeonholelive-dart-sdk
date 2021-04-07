import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/consent.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/linked_in.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/twitter.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/custom_profile_field.dart';
import 'package:pigeonholelive_sdk/src/models/date_time_converter.dart';

part 'attendee.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
@DateTimeConverter()
class Attendee implements CastableToJson {
  int? id;
  String? attendeeCode;
  DateTime? signInTime;
  Consent? consent;
  LinkedIn? linkedIn;
  Twitter? twitter;
  @JsonKey(ignore: true)
  CustomProfileField? customProfileField;

  Attendee({
    this.id,
    this.attendeeCode,
    this.signInTime,
    this.consent,
    this.linkedIn,
    this.twitter,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    var attendee = _$AttendeeFromJson(json);
    attendee.customProfileField = CustomProfileField.fromJson(json
      ..removeWhere((key, value) {
        return key == 'id' ||
            key == 'attendeeCode' ||
            key == 'signInTime' ||
            key == 'consent' ||
            key == 'linkedIn' ||
            key == 'twitter';
      }));
    return attendee;
  }

  @override
  Map<String, dynamic> toJson() {
    var attendeeToJson = _$AttendeeToJson(this);
    attendeeToJson.addAll(customProfileField?.toJson() ?? {});
    return attendeeToJson;
  }

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
