// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkedIn _$LinkedInFromJson(Map<String, dynamic> json) {
  return LinkedIn(
    url: json['url'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    profileImageUrl: json['profileImageUrl'] as String?,
  );
}

Map<String, dynamic> _$LinkedInToJson(LinkedIn instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('profileImageUrl', instance.profileImageUrl);
  return val;
}
