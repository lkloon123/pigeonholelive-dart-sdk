import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/attendee/profile_field/profile_field.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'multi_choice.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MultiChoice extends ProfileField implements CastableToJson {
  List<String>? options;

  MultiChoice({
    String? name,
    bool? required,
    String? type,
    int? order,
    this.options,
  }) : super(
          name: name,
          required: required,
          type: type,
          order: order,
        );

  factory MultiChoice.fromJson(Map<String, dynamic> json) =>
      _$MultiChoiceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MultiChoiceToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
