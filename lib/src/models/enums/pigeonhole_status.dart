import 'package:json_annotation/json_annotation.dart';

enum PigeonholeStatus {
  @JsonValue('new')
  newPigeonhole,

  @JsonValue('upcoming')
  upcoming,

  @JsonValue('live')
  live,

  @JsonValue('ended')
  ended,
}
