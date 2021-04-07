import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/enums/speaker_role.dart';

part 'speaker_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SpeakerForm implements CastableToJson {
  int id;
  SpeakerRole role;

  SpeakerForm({
    required this.id,
    required this.role,
  });

  factory SpeakerForm.fromJson(Map<String, dynamic> json) =>
      _$SpeakerFormFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SpeakerFormToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
