import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/enums/poll_question_type.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_question/poll_question.dart';

part 'poll_question_text.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PollQuestionText extends PollQuestion implements CastableToJson {
  List<String>? options;
  @JsonKey(defaultValue: 1)
  int? votesPerUser;
  @JsonKey(defaultValue: 'vertical')
  String? chartType;

  PollQuestionText({
    String? question,
    PollQuestionType? type,
    this.options,
    this.votesPerUser,
    this.chartType,
  }) : super(
          question: question,
          type: type,
        );

  factory PollQuestionText.fromJson(Map<String, dynamic> json) =>
      _$PollQuestionTextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PollQuestionTextToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
