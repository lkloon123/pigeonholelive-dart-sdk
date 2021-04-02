// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationError _$ValidationErrorFromJson(Map<String, dynamic> json) {
  return ValidationError(
    field: json['field'] as String?,
    message: json['message'] as String?,
  );
}

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('field', instance.field);
  writeNotNull('message', instance.message);
  return val;
}
