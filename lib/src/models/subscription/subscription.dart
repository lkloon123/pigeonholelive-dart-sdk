import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';

part 'subscription.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Subscription implements CastableToJson {
  int? id;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? timezone;

  Subscription({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.timezone,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
