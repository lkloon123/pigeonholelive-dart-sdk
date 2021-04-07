// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_time_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneTimeLink _$OneTimeLinkFromJson(Map<String, dynamic> json) {
  return OneTimeLink(
    oneTimeLinkFor: json['for'] as String?,
    token: json['token'] as String?,
    expiresAt: const DateTimeConverter().fromJson(json['expiresAt'] as String?),
    expiresAtUnix: json['expiresAtUnix'] as String?,
    used: json['used'] as bool?,
    link: json['link'] as String?,
  );
}

Map<String, dynamic> _$OneTimeLinkToJson(OneTimeLink instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('for', instance.oneTimeLinkFor);
  writeNotNull('token', instance.token);
  writeNotNull(
      'expiresAt', const DateTimeConverter().toJson(instance.expiresAt));
  writeNotNull('expiresAtUnix', instance.expiresAtUnix);
  writeNotNull('used', instance.used);
  writeNotNull('link', instance.link);
  return val;
}
