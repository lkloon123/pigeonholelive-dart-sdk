// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(
    question: json['question'] as String?,
    type: _$enumDecodeNullable(_$PollQuestionTypeEnumMap, json['type']),
    steps: json['steps'] as int? ?? 5,
    icon: json['icon'] as String? ?? 'star',
  );
}

Map<String, dynamic> _$RatingToJson(Rating instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('question', instance.question);
  writeNotNull('type', _$PollQuestionTypeEnumMap[instance.type]);
  writeNotNull('steps', instance.steps);
  writeNotNull('icon', instance.icon);
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

const _$PollQuestionTypeEnumMap = {
  PollQuestionType.text: 'text',
  PollQuestionType.numericScale: 'numeric_scale',
  PollQuestionType.draggableScale: 'draggable_scale',
  PollQuestionType.rating: 'rating',
};
