import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/enums/poll_question_type.dart';

part 'poll_question.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PollQuestion implements CastableToJson {
  String? question;
  PollQuestionType? type;

  PollQuestion({
    this.question,
    this.type,
  });

  factory PollQuestion.fromJson(Map<String, dynamic> json) =>
      _$PollQuestionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PollQuestionToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
