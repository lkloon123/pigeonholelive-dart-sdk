// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opentext.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Opentext _$OpentextFromJson(Map<String, dynamic> json) {
  return Opentext(
    name: json['name'] as String?,
    required: json['required'] as bool?,
    type: json['type'] as String?,
    order: json['order'] as int?,
  );
}

Map<String, dynamic> _$OpentextToJson(Opentext instance) {
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
