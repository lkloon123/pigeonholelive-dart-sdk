// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_time_link_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneTimeLinkForm _$OneTimeLinkFormFromJson(Map<String, dynamic> json) {
  return OneTimeLinkForm(
    oneTimeLinkFor: json['for'] as String,
    ttl: json['ttl'] as int,
  );
}

Map<String, dynamic> _$OneTimeLinkFormToJson(OneTimeLinkForm instance) =>
    <String, dynamic>{
      'for': instance.oneTimeLinkFor,
      'ttl': instance.ttl,
    };
