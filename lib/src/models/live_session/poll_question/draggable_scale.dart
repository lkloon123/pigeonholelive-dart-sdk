import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/enums/poll_question_type.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_question/poll_question.dart';

part 'draggable_scale.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DraggableScale extends PollQuestion implements CastableToJson {
  @JsonKey(defaultValue: 1)
  int? lowestValue;
  @JsonKey(defaultValue: 5)
  int? highestValue;
  @JsonKey(defaultValue: 'Strongly disagree')
  String? lowestLabel;
  @JsonKey(defaultValue: 'Strongly agree')
  String? highestLabel;

  DraggableScale({
    String? question,
    PollQuestionType? type,
    this.lowestValue,
    this.highestValue,
    this.lowestLabel,
    this.highestLabel,
  }) : super(
          question: question,
          type: type,
        );

  factory DraggableScale.fromJson(Map<String, dynamic> json) =>
      _$DraggableScaleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DraggableScaleToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
