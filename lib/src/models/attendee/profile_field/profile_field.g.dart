// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileField _$ProfileFieldFromJson(Map<String, dynamic> json) {
  return ProfileField(
    name: json['name'] as String?,
    required: json['required'] as bool?,
    type: json['type'] as String?,
    order: json['order'] as int?,
  );
}

Map<String, dynamic> _$ProfileFieldToJson(ProfileField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('required', instance.required);
  writeNotNull('type', instance.type);
  writeNotNull('order', instance.order);
  return val;
}
