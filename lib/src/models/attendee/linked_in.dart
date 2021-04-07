import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'linked_in.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LinkedIn implements CastableToJson {
  String? url;
  String? firstName;
  String? lastName;
  String? profileImageUrl;

  LinkedIn({
    this.url,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
  });

  factory LinkedIn.fromJson(Map<String, dynamic> json) =>
      _$LinkedInFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LinkedInToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
