// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consent _$ConsentFromJson(Map<String, dynamic> json) {
  return Consent(
    obtained: json['obtained'] as bool?,
    obtainedAt: json['obtainedAt'] == null
        ? null
        : DateTime.parse(json['obtainedAt'] as String),
  );
}

Map<String, dynamic> _$ConsentToJson(Consent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('obtained', instance.obtained);
  writeNotNull('obtainedAt', instance.obtainedAt?.toIso8601String());
  return val;
}
