import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/date_time_converter.dart';
import 'package:pigeonholelive_sdk/src/models/enums/pigeonhole_status.dart';
import 'package:pigeonholelive_sdk/src/models/pigeonhole/pigeonhole_links.dart';

part 'pigeonhole.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
@DateTimeConverter()
class Pigeonhole implements CastableToJson {
  int? id;
  String? name;
  String? description;
  String? passcode;
  DateTime? startDate;
  DateTime? endDate;
  PigeonholeStatus? status;
  String? timezone;
  bool? attendeeProfiles;
  bool? registrants;
  bool? attendeeCodeRequired;
  @JsonKey(name: 'links')
  PigeonholeLinks? pigeonholeLinks;

  Pigeonhole({
    this.id,
    this.name,
    this.description,
    this.passcode,
    this.startDate,
    this.endDate,
    this.status,
    this.timezone,
    this.attendeeProfiles,
    this.registrants,
    this.attendeeCodeRequired,
    this.pigeonholeLinks,
  });

  factory Pigeonhole.fromJson(Map<String, dynamic> json) =>
      _$PigeonholeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PigeonholeToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
