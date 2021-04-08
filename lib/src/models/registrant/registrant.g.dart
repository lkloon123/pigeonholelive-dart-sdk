// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registrant _$RegistrantFromJson(Map<String, dynamic> json) {
  return Registrant(
    id: json['id'] as int?,
    attendeeCode: json['attendeeCode'] as String?,
    signedIn: json['signedIn'] as bool?,
    customProfileField: json['customProfileField'] == null
        ? null
        : CustomProfileField.fromJson(
            json['customProfileField'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RegistrantToJson(Registrant instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('attendeeCode', instance.attendeeCode);
  writeNotNull('signedIn', instance.signedIn);
  writeNotNull('customProfileField', instance.customProfileField?.toJson());
  return val;
}
