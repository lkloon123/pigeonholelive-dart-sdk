// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrant_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrantForm _$RegistrantFormFromJson(Map<String, dynamic> json) {
  return RegistrantForm(
    attendeeCode: json['attendeeCode'] as String?,
  );
}

Map<String, dynamic> _$RegistrantFormToJson(RegistrantForm instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('attendeeCode', instance.attendeeCode);
  return val;
}
