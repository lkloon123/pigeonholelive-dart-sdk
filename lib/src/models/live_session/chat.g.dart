// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
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
    anonymousMessages: json['anonymousMessages'] as bool? ?? false,
    messageFiltering: json['messageFiltering'] as bool? ?? false,
    replies: json['replies'] as bool? ?? false,
    messagesAvailableAfterEnd:
        json['messagesAvailableAfterEnd'] as bool? ?? true,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) {
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
  writeNotNull('anonymousMessages', instance.anonymousMessages);
  writeNotNull('messageFiltering', instance.messageFiltering);
  writeNotNull('replies', instance.replies);
  writeNotNull('messagesAvailableAfterEnd', instance.messagesAvailableAfterEnd);
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
