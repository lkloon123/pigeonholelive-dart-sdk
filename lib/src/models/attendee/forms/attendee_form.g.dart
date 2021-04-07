// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendeeForm _$AttendeeFormFromJson(Map<String, dynamic> json) {
  return AttendeeForm(
    id: json['id'] as int?,
    attendeeCode: json['attendeeCode'] as String?,
  );
}

Map<String, dynamic> _$AttendeeFormToJson(AttendeeForm instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('attendeeCode', instance.attendeeCode);
  return val;
}
