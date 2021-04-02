import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/date_time_converter.dart';

part 'workspace.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
@DateTimeConverter()
class Workspace implements CastableToJson {
  int? id;
  String? name;
  String? type;
  String? organisationName;
  int? maxMembers;
  DateTime? createdAt;

  Workspace({
    this.id,
    this.name,
    this.type,
    this.organisationName,
    this.maxMembers,
    this.createdAt,
  });

  factory Workspace.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WorkspaceToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
