// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pigeonhole_links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PigeonholeLinks _$PigeonholeLinksFromJson(Map<String, dynamic> json) {
  return PigeonholeLinks(
    audienceWebApp: json['audienceWebApp'] == null
        ? null
        : PigeonholeLink.fromJson(
            json['audienceWebApp'] as Map<String, dynamic>),
    projectorPanel: json['projectorPanel'] == null
        ? null
        : PigeonholeLink.fromJson(
            json['projectorPanel'] as Map<String, dynamic>),
    adminPanel: json['adminPanel'] == null
        ? null
        : PigeonholeLink.fromJson(json['adminPanel'] as Map<String, dynamic>),
    moderatorPanel: json['moderatorPanel'] == null
        ? null
        : PigeonholeLink.fromJson(
            json['moderatorPanel'] as Map<String, dynamic>),
    kiosk: json['kiosk'] == null
        ? null
        : PigeonholeLink.fromJson(json['kiosk'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PigeonholeLinksToJson(PigeonholeLinks instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('audienceWebApp', instance.audienceWebApp?.toJson());
  writeNotNull('projectorPanel', instance.projectorPanel?.toJson());
  writeNotNull('adminPanel', instance.adminPanel?.toJson());
  writeNotNull('moderatorPanel', instance.moderatorPanel?.toJson());
  writeNotNull('kiosk', instance.kiosk?.toJson());
  return val;
}
