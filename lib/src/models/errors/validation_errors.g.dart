// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_errors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationErrors _$ValidationErrorsFromJson(Map<String, dynamic> json) {
  return ValidationErrors(
    errors: (json['errors'] as List<dynamic>?)
        ?.map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
        .toList(),
    code: json['code'] as int?,
    message: json['message'] as String?,
  );
}

Map<String, dynamic> _$ValidationErrorsToJson(ValidationErrors instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('message', instance.message);
  writeNotNull('errors', instance.errors?.map((e) => e.toJson()).toList());
  return val;
}
