import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/date_time_converter.dart';
import 'package:pigeonholelive_sdk/src/models/enums/live_session_type.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/live_session.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_question/draggable_scale.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_question/numeric_scale.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_question/poll_question.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_question/rating.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_question/poll_question_text.dart';
import 'package:pigeonholelive_sdk/src/models/pigeonhole/pigeonhole_links.dart';

part 'poll_multiple_choice.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
@DateTimeConverter()
class PollMultipleChoice extends LiveSession implements CastableToJson {
  @JsonKey(defaultValue: true)
  bool? anonymousResponses;
  @JsonKey(defaultValue: true)
  bool? comments;
  @JsonKey(defaultValue: false)
  bool? commentFiltering;
  @JsonKey(defaultValue: false)
  bool? liveResults;
  @JsonKey(defaultValue: false)
  bool? changeVote;
  @JsonKey(defaultValue: true)
  bool? pollAvailableAfterEnd;
  @JsonKey(defaultValue: 'Multiple choice poll')
  String? sessionLabel;
  @JsonKey(defaultValue: 'Enter this Poll')
  String? buttonText;
  String? prePollMessage;
  @JsonKey(defaultValue: 'Thank you for participating!')
  String? postPollMessage;
  @JsonKey(name: 'questions')
  @_PollQuestionConverter()
  List<dynamic>? pollQuestion;

  PollMultipleChoice({
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

  factory PollMultipleChoice.fromJson(Map<String, dynamic> json) =>
      _$PollMultipleChoiceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PollMultipleChoiceToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}

class _PollQuestionConverter implements JsonConverter<PollQuestion, Object> {
  const _PollQuestionConverter();

  @override
  PollQuestion fromJson(Object json) {
    if (json is Map<String, dynamic> && json.containsKey('type')) {
      if (json['type'] == 'text') {
        return PollQuestionText.fromJson(json);
      }

      if (json['type'] == 'numeric_scale') {
        return NumericScale.fromJson(json);
      }

      if (json['type'] == 'draggable_scale') {
        return DraggableScale.fromJson(json);
      }

      if (json['type'] == 'rating') {
        return Rating.fromJson(json);
      }
    }

    return json as PollQuestion;
  }

  @override
  Object toJson(PollQuestion object) {
    return object;
  }
}
