// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiChoice _$MultiChoiceFromJson(Map<String, dynamic> json) {
  return MultiChoice(
    name: json['name'] as String?,
    required: json['required'] as bool?,
    type: json['type'] as String?,
    order: json['order'] as int?,
    options:
        (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$MultiChoiceToJson(MultiChoice instance) {
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
  writeNotNull('options', instance.options);
  return val;
}
