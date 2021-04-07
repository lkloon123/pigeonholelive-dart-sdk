import 'package:json_annotation/json_annotation.dart';

enum SpeakerRole {
  @JsonValue('speaker')
  speaker,

  @JsonValue('moderator')
  moderator,
}
