// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Insight _$InsightFromJson(Map<String, dynamic> json) {
  return Insight(
    questionId: json['questionId'] as int?,
    content: json['content'] as String?,
    options: (json['options'] as List<dynamic>?)
        ?.map((e) => PollOptionInsight.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$InsightToJson(Insight instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('questionId', instance.questionId);
  writeNotNull('content', instance.content);
  writeNotNull('options', instance.options?.map((e) => e.toJson()).toList());
  return val;
}
