import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/date_time_converter.dart';
import 'package:pigeonholelive_sdk/src/models/enums/live_session_type.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/live_session.dart';
import 'package:pigeonholelive_sdk/src/models/pigeonhole/pigeonhole_links.dart';

part 'chat.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
@DateTimeConverter()
class Chat extends LiveSession implements CastableToJson {
  @JsonKey(defaultValue: false)
  bool? anonymousMessages;
  @JsonKey(defaultValue: false)
  bool? messageFiltering;
  @JsonKey(defaultValue: false)
  bool? replies;
  @JsonKey(defaultValue: true)
  bool? messagesAvailableAfterEnd;

  Chat({
    int? id,
    String? name,
    String? description,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    LiveSessionType? liveSessionType,
    PigeonholeLinks? pigeonholeLinks,
    int? parentSessionId,
    this.anonymousMessages,
    this.messageFiltering,
    this.replies,
    this.messagesAvailableAfterEnd,
  }) : super(
          id: id,
          name: name,
          description: description,
          startDate: startDate,
          endDate: endDate,
          createdAt: createdAt,
          liveSessionType: liveSessionType,
          pigeonholeLinks: pigeonholeLinks,
          parentSessionId: parentSessionId,
        );

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChatToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
