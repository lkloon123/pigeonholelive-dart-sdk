// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pigeonhole_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PigeonholeError _$PigeonholeErrorFromJson(Map<String, dynamic> json) {
  return PigeonholeError(
    code: json['code'] as int?,
    message: json['message'] as String?,
  );
}

Map<String, dynamic> _$PigeonholeErrorToJson(PigeonholeError instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('message', instance.message);
  return val;
}
