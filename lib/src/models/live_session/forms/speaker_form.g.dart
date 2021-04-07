// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakerForm _$SpeakerFormFromJson(Map<String, dynamic> json) {
  return SpeakerForm(
    id: json['id'] as int,
    role: _$enumDecode(_$SpeakerRoleEnumMap, json['role']),
  );
}

Map<String, dynamic> _$SpeakerFormToJson(SpeakerForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$SpeakerRoleEnumMap[instance.role],
    };

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

const _$SpeakerRoleEnumMap = {
  SpeakerRole.speaker: 'speaker',
  SpeakerRole.moderator: 'moderator',
};
