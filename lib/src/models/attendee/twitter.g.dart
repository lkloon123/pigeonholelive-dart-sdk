// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Twitter _$TwitterFromJson(Map<String, dynamic> json) {
  return Twitter(
    screenName: json['screenName'] as String?,
    profileImageUrl: json['profileImageUrl'] as String?,
  );
}

Map<String, dynamic> _$TwitterToJson(Twitter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('screenName', instance.screenName);
  writeNotNull('profileImageUrl', instance.profileImageUrl);
  return val;
}
