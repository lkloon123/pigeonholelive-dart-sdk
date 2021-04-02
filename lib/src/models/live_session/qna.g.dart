// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qna.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qna _$QnaFromJson(Map<String, dynamic> json) {
  return Qna(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    location: json['location'] as String?,
    startDate: const DateTimeConverter().fromJson(json['startDate'] as String?),
    endDate: const DateTimeConverter().fromJson(json['endDate'] as String?),
    createdAt: const DateTimeConverter().fromJson(json['createdAt'] as String?),
    liveSessionType:
        _$enumDecodeNullable(_$LiveSessionTypeEnumMap, json['type']),
    pigeonholeLinks: json['links'] == null
        ? null
        : PigeonholeLinks.fromJson(json['links'] as Map<String, dynamic>),
    parentSessionId: json['parentSessionId'] as int?,
    logoPosition: json['logoPosition'] as String? ?? 'header',
    anonymousResponses: json['anonymousResponses'] as bool? ?? true,
    questionFiltering: json['questionFiltering'] as bool? ?? false,
    comments: json['comments'] as bool? ?? true,
    commentFiltering: json['commentFiltering'] as bool? ?? false,
    answers: json['answers'] as bool? ?? false,
    answerRatings: json['answerRatings'] as bool? ?? true,
    questionsAvailableAfterEnd:
        json['questionsAvailableAfterEnd'] as bool? ?? true,
    adminCollaboration: json['adminCollaboration'] as bool? ?? false,
    hideOtherAttendeesQuestions:
        json['hideOtherAttendeesQuestions'] as bool? ?? false,
    questionVotes: json['questionVotes'] as bool? ?? true,
    tagsRequired: json['tagsRequired'] as bool? ?? false,
    tags: json['tags'] as String?,
    sessionLabel: json['sessionLabel'] as String? ?? 'Q&A',
    buttonText: json['buttonText'] as String? ?? 'Enter this Q&A',
  );
}

Map<String, dynamic> _$QnaToJson(Qna instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('location', instance.location);
  writeNotNull(
      'startDate', const DateTimeConverter().toJson(instance.startDate));
  writeNotNull('endDate', const DateTimeConverter().toJson(instance.endDate));
  writeNotNull(
      'createdAt', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull('type', _$LiveSessionTypeEnumMap[instance.liveSessionType]);
  writeNotNull('links', instance.pigeonholeLinks?.toJson());
  writeNotNull('parentSessionId', instance.parentSessionId);
  writeNotNull('logoPosition', instance.logoPosition);
  writeNotNull('anonymousResponses', instance.anonymousResponses);
  writeNotNull('questionFiltering', instance.questionFiltering);
  writeNotNull('comments', instance.comments);
  writeNotNull('commentFiltering', instance.commentFiltering);
  writeNotNull('answers', instance.answers);
  writeNotNull('answerRatings', instance.answerRatings);
  writeNotNull(
      'questionsAvailableAfterEnd', instance.questionsAvailableAfterEnd);
  writeNotNull('adminCollaboration', instance.adminCollaboration);
  writeNotNull(
      'hideOtherAttendeesQuestions', instance.hideOtherAttendeesQuestions);
  writeNotNull('questionVotes', instance.questionVotes);
  writeNotNull('tagsRequired', instance.tagsRequired);
  writeNotNull('tags', instance.tags);
  writeNotNull('sessionLabel', instance.sessionLabel);
  writeNotNull('buttonText', instance.buttonText);
  return val;
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$LiveSessionTypeEnumMap = {
  LiveSessionType.qna: 'qna',
  LiveSessionType.pollMultipleChoice: 'poll_multiple_choice',
  LiveSessionType.pollQuiz: 'poll_quiz',
  LiveSessionType.pollAssessment: 'poll_assessment',
  LiveSessionType.pollWordCloud: 'poll_word_cloud',
  LiveSessionType.pollOpenEnded: 'poll_open_ended',
  LiveSessionType.survey: 'survey',
  LiveSessionType.breakType: 'break',
  LiveSessionType.regular: 'regular',
  LiveSessionType.chat: 'chat',
};
