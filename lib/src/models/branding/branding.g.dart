// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branding _$BrandingFromJson(Map<String, dynamic> json) {
  return Branding(
    id: json['id'] as int?,
    name: json['name'] as String?,
    customUrl: json['customUrl'] as String?,
  );
}

Map<String, dynamic> _$BrandingToJson(Branding instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('customUrl', instance.customUrl);
  return val;
}
