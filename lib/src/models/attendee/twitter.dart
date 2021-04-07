import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'twitter.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Twitter implements CastableToJson {
  String? screenName;
  String? profileImageUrl;

  Twitter({
    this.screenName,
    this.profileImageUrl,
  });

  factory Twitter.fromJson(Map<String, dynamic> json) =>
      _$TwitterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TwitterToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
