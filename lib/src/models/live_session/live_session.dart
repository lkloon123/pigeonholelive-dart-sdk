import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/date_time_converter.dart';
import 'package:pigeonholelive_sdk/src/models/enums/live_session_type.dart';
import 'package:pigeonholelive_sdk/src/models/pigeonhole/pigeonhole_links.dart';

part 'live_session.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
@DateTimeConverter()
class LiveSession implements CastableToJson {
  int? id;
  String? name;
  String? description;
  String? location;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  @JsonKey(name: 'type')
  LiveSessionType? liveSessionType;
  @JsonKey(name: 'links')
  PigeonholeLinks? pigeonholeLinks;
  int? parentSessionId;

  LiveSession({
    this.id,
    this.name,
    this.description,
    this.location,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.liveSessionType,
    this.pigeonholeLinks,
    this.parentSessionId,
  });

  factory LiveSession.fromJson(Map<String, dynamic> json) =>
      _$LiveSessionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LiveSessionToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
