import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/insight/poll_option_insight.dart';

part 'insight.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Insight implements CastableToJson {
  int? questionId;
  String? content;
  List<PollOptionInsight>? options;

  Insight({this.questionId, this.content, this.options});

  factory Insight.fromJson(Map<String, dynamic> json) =>
      _$InsightFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InsightToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
