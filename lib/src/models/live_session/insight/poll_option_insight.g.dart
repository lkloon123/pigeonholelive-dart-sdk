// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_option_insight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollOptionInsight _$PollOptionInsightFromJson(Map<String, dynamic> json) {
  return PollOptionInsight(
    id: json['id'] as int?,
    content: json['content'] as String?,
    votes: json['votes'] as int?,
    percentage: (json['percentage'] as num?)?.toDouble(),
    correct: json['correct'] as bool?,
  );
}

Map<String, dynamic> _$PollOptionInsightToJson(PollOptionInsight instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('content', instance.content);
  writeNotNull('votes', instance.votes);
  writeNotNull('percentage', instance.percentage);
  writeNotNull('correct', instance.correct);
  return val;
}
