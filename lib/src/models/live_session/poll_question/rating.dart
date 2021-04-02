import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/enums/poll_question_type.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_question/poll_question.dart';

part 'rating.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Rating extends PollQuestion implements CastableToJson {
  @JsonKey(defaultValue: 5)
  int? steps;
  @JsonKey(defaultValue: 'star')
  String? icon;

  Rating({
    String? question,
    PollQuestionType? type,
    this.steps,
    this.icon,
  }) : super(
          question: question,
          type: type,
        );

  factory Rating.fromJson(Map<String, dynamic> json) =>
      _$RatingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RatingToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
