import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/date_time_converter.dart';
import 'package:pigeonholelive_sdk/src/models/enums/live_session_type.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/live_session.dart';
import 'package:pigeonholelive_sdk/src/models/pigeonhole/pigeonhole_links.dart';

part 'qna.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
@DateTimeConverter()
class Qna extends LiveSession implements CastableToJson {
  @JsonKey(defaultValue: 'header')
  String? logoPosition;
  @JsonKey(defaultValue: true)
  bool? anonymousResponses;
  @JsonKey(defaultValue: false)
  bool? questionFiltering;
  @JsonKey(defaultValue: true)
  bool? comments;
  @JsonKey(defaultValue: false)
  bool? commentFiltering;
  @JsonKey(defaultValue: false)
  bool? answers;
  @JsonKey(defaultValue: true)
  bool? answerRatings;
  @JsonKey(defaultValue: true)
  bool? questionsAvailableAfterEnd;
  @JsonKey(defaultValue: false)
  bool? adminCollaboration;
  @JsonKey(defaultValue: false)
  bool? hideOtherAttendeesQuestions;
  @JsonKey(defaultValue: true)
  bool? questionVotes;
  @JsonKey(defaultValue: false)
  bool? tagsRequired;
  String? tags;
  @JsonKey(defaultValue: 'Q&A')
  String? sessionLabel;
  @JsonKey(defaultValue: 'Enter this Q&A')
  String? buttonText;

  Qna({
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
    this.logoPosition,
    this.anonymousResponses,
    this.questionFiltering,
    this.comments,
    this.commentFiltering,
    this.answers,
    this.answerRatings,
    this.questionsAvailableAfterEnd,
    this.adminCollaboration,
    this.hideOtherAttendeesQuestions,
    this.questionVotes,
    this.tagsRequired,
    this.tags,
    this.sessionLabel,
    this.buttonText,
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

  factory Qna.fromJson(Map<String, dynamic> json) => _$QnaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QnaToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
