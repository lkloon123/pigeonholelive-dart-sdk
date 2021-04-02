// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workspace _$WorkspaceFromJson(Map<String, dynamic> json) {
  return Workspace(
    id: json['id'] as int?,
    name: json['name'] as String?,
    type: json['type'] as String?,
    organisationName: json['organisationName'] as String?,
    maxMembers: json['maxMembers'] as int?,
    createdAt: const DateTimeConverter().fromJson(json['createdAt'] as String?),
  );
}

Map<String, dynamic> _$WorkspaceToJson(Workspace instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('type', instance.type);
  writeNotNull('organisationName', instance.organisationName);
  writeNotNull('maxMembers', instance.maxMembers);
  writeNotNull(
      'createdAt', const DateTimeConverter().toJson(instance.createdAt));
  return val;
}
