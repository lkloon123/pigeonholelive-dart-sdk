// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pigeonhole_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PigeonholeLink _$PigeonholeLinkFromJson(Map<String, dynamic> json) {
  return PigeonholeLink(
    accessLevel: _$enumDecodeNullable(
        _$PigeonholeLinkAccessLevelEnumMap, json['accessLevel']),
    url: json['url'] as String?,
  );
}

Map<String, dynamic> _$PigeonholeLinkToJson(PigeonholeLink instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'accessLevel', _$PigeonholeLinkAccessLevelEnumMap[instance.accessLevel]);
  writeNotNull('url', instance.url);
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

const _$PigeonholeLinkAccessLevelEnumMap = {
  PigeonholeLinkAccessLevel.anyone: 'anyone',
  PigeonholeLinkAccessLevel.members: 'members',
};
