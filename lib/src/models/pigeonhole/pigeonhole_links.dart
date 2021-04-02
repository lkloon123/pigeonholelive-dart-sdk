import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pigeonholelive_sdk/src/models/castable_to_json.dart';
import 'package:pigeonholelive_sdk/src/models/pigeonhole/pigeonhole_link.dart';

part 'pigeonhole_links.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PigeonholeLinks implements CastableToJson {
  PigeonholeLink? audienceWebApp;
  PigeonholeLink? projectorPanel;
  PigeonholeLink? adminPanel;
  PigeonholeLink? moderatorPanel;
  PigeonholeLink? kiosk;

  PigeonholeLinks({
    this.audienceWebApp,
    this.projectorPanel,
    this.adminPanel,
    this.moderatorPanel,
    this.kiosk,
  });

  factory PigeonholeLinks.fromJson(Map<String, dynamic> json) =>
      _$PigeonholeLinksFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PigeonholeLinksToJson(this);

  @override
  String toString() => '$runtimeType ' + jsonEncode(toJson());
}
