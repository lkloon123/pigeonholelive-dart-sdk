// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendee _$AttendeeFromJson(Map<String, dynamic> json) {
  return Attendee(
    id: json['id'] as int?,
    attendeeCode: json['attendeeCode'] as String?,
    signInTime:
        const DateTimeConverter().fromJson(json['signInTime'] as String?),
    consent: json['consent'] == null
        ? null
        : Consent.fromJson(json['consent'] as Map<String, dynamic>),
    linkedIn: json['linkedIn'] == null
        ? null
        : LinkedIn.fromJson(json['linkedIn'] as Map<String, dynamic>),
    twitter: json['twitter'] == null
        ? null
        : Twitter.fromJson(json['twitter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AttendeeToJson(Attendee instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('attendeeCode', instance.attendeeCode);
  writeNotNull(
      'signInTime', const DateTimeConverter().toJson(instance.signInTime));
  writeNotNull('consent', instance.consent?.toJson());
  writeNotNull('linkedIn', instance.linkedIn?.toJson());
  writeNotNull('twitter', instance.twitter?.toJson());
  return val;
}
