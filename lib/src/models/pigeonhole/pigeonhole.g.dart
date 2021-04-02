// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pigeonhole.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pigeonhole _$PigeonholeFromJson(Map<String, dynamic> json) {
  return Pigeonhole(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    passcode: json['passcode'] as String?,
    startDate: const DateTimeConverter().fromJson(json['startDate'] as String?),
    endDate: const DateTimeConverter().fromJson(json['endDate'] as String?),
    status: _$enumDecodeNullable(_$PigeonholeStatusEnumMap, json['status']),
    timezone: json['timezone'] as String?,
    attendeeProfiles: json['attendeeProfiles'] as bool?,
    registrants: json['registrants'] as bool?,
    attendeeCodeRequired: json['attendeeCodeRequired'] as bool?,
    pigeonholeLinks: json['links'] == null
        ? null
        : PigeonholeLinks.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PigeonholeToJson(Pigeonhole instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('passcode', instance.passcode);
  writeNotNull(
      'startDate', const DateTimeConverter().toJson(instance.startDate));
  writeNotNull('endDate', const DateTimeConverter().toJson(instance.endDate));
  writeNotNull('status', _$PigeonholeStatusEnumMap[instance.status]);
  writeNotNull('timezone', instance.timezone);
  writeNotNull('attendeeProfiles', instance.attendeeProfiles);
  writeNotNull('registrants', instance.registrants);
  writeNotNull('attendeeCodeRequired', instance.attendeeCodeRequired);
  writeNotNull('links', instance.pigeonholeLinks?.toJson());
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

const _$PigeonholeStatusEnumMap = {
  PigeonholeStatus.newPigeonhole: 'new',
  PigeonholeStatus.upcoming: 'upcoming',
  PigeonholeStatus.live: 'live',
  PigeonholeStatus.ended: 'ended',
};
