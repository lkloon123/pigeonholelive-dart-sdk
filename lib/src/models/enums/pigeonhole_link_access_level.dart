import 'package:json_annotation/json_annotation.dart';

enum PigeonholeLinkAccessLevel {
  @JsonValue('anyone')
  anyone,

  @JsonValue('members')
  members,
}
