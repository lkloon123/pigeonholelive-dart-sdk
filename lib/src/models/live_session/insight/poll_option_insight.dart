import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'poll_option_insight.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PollOptionInsight implements CastableToJson {
  int? id;
  String? content;
  int? votes;
  double? percentage;
  bool? correct;

  PollOptionInsight({
    this.id,
    this.content,
    this.votes,
    this.percentage,
    this.correct,
  });

  factory PollOptionInsight.fromJson(Map<String, dynamic> json) =>
      _$PollOptionInsightFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PollOptionInsightToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
